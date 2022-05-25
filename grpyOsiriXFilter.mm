//
//  PluginTemplateFilter.m
//  PluginTemplate
//
//  Copyright (c) CURRENT_YEAR YOUR_NAME. All rights reserved.
//

#import "grpyOsiriXFilter.h"
#import "ServerAdaptor.h"

#include "horos.pb.h"
#include "horos.grpc.pb.h"

#include <fstream>
#include <set>

// quill logger
#include <stdlib.h>
static const char* LogFile = "uk.ac.icr.pyosirix_daily.log";

#import <browserController.h>
#import <DicomSeries.h>
#import <DicomStudy.h>
#import <DicomImage.h>
#import <OsiriXAPI/DicomDatabase.h>

using pyosirix::DicomDataRequest;
using pyosirix::DicomDataResponse;
using pyosirix::ImageGetRequest;
using pyosirix::ImageGetResponse;
using pyosirix::ImageSetRequest;
using pyosirix::ImageSetResponse;
using pyosirix::ROIListRequest;
using pyosirix::ROIListResponse;
//using pyosirix::ROI; ... not a good idea, too ambiguous

//-----------------------------------------------------------------------------------

@implementation grpyOsiriXFilter

- (void) initPlugin
{
    if( [NSThread isMultiThreaded] )
    {
        NSLog( @"<pyOsiriXii> is threaded\n" );
    }
    else
    {
        // Initialize Cocoa threads .... needed even if using posix threads
        // We would expect Horos/OsiriX to be threaded anyway but.....
        // *** Note this just crashes the plugin or breaks loading ***
        //[NSThread detachNewThreadSelector:@selector(dummyFunc:) toTarget:[Dummy alloc] withObject:nil];
        //clean up
    }
    
    //NSMutableDictionary *grpcObjects = [[NSMutableDictionary alloc] init];
    DisplayedSeries = [[NSMutableArray alloc] init];
    
    [self StartLogger];
}

- (void) dealloc {
    
    //[grpcObjects release];
    [Manager release];    
    [super dealloc];
}

-(void)StartLogger {
    
    std::string log_file_name( LogFile );
    const char* HOME = std::getenv( "HOME" );
    if( HOME )
        log_file_name = std::string( HOME ) + "/Library/Logs/"
            + log_file_name; // otherwise, leave in current working dir
    
    // Start the backend logging thread
    quill::start();

    // Create a rotating file handler which rotates daily at 02:00
    LogHandler.reset( quill::time_rotating_file_handler(
        log_file_name, "w", "daily", 1, 10, quill::Timezone::LocalTime, "01:00" ) );
    
    LogHandler->set_log_level(quill::LogLevel::Info);
    // Create a logger using this handler
    Logger.reset( quill::create_logger("day_log", LogHandler.get()) );

    // enable a backtrace that will get flushed when we log CRITICAL
    Logger->init_backtrace(2, quill::LogLevel::Critical);
    LOG_BACKTRACE(Logger, "Backtrace log {}", 1);
    LOG_BACKTRACE(Logger, "Backtrace log {}", 2);
    
    NSString* version = [[self GetCurrentVersionString] retain];
    if( [version UTF8String] != nil )
        LOG_INFO(Logger, "Initializing grpyHoros:OsiriX {}", [version UTF8String] );
    [version release];
}

- (long) filterImage:(NSString*) menuName
{
    [self StartServer];
    
     return 0;
}

-(void)StartServer
{
    //Declare the log window, passing ownership to Manager
    Console = [[ConsoleController alloc] init];

    //Declare the adaptor communication object and pass ownership to Manager
    Adaptor = new pyosirix::ServerAdaptor;
    
    Manager = [[ServerManager alloc] init];

    LOG_INFO(Logger, "Starting server..." );
    
    [Manager StartServer:(void*)self
             withAdaptor:Adaptor
             withConsole:Console withPort:@"50051"];
}

/*
 // this works to retrieve the selected series etc.... kept here to help
 // with future searching

 BrowserController* browser = [BrowserController currentBrowser];
 NSString* path = [browser documentsDirectory];
 [Console AddText:[NSString stringWithFormat:@"Path: %@", path]];

 NSArray* series_or_studies = [browser databaseSelection];
 NSMutableArray* collected_series = [NSMutableArray array];
 [self CollectSeries: series_or_studies into:collected_series];
 
 if( collected_series )
 {
     for (NSUInteger i = 0; i < collected_series.count; ++i) {
         DicomSeries* s = [collected_series objectAtIndex:i];
         //if (![DicomStudy displaySeriesWithSOPClassUID:s.seriesSOPClassUID andSeriesDescription:s.name])
         //    [series removeObjectAtIndex:i--];
         [Console AddText:[NSString stringWithFormat:@"Study UID: %@ | Series UID: %@ (Patient: %@)",
                           [[s study] studyInstanceUID], [s seriesInstanceUID], [[s study] patientID] ] ];
     }
 }
 
 //... maybe we can query the database directly.... ?
 //DicomDatabase* db = [[BrowserController currentBrowser] database];
 //[db objectsWithIDs:<#(NSArray *)#>
 
 */

-(void)GetCurrentImageData:(NSString*)arg_string {
    
    LOG_INFO(Logger, "GetCurrentImageData: {} ...", [arg_string UTF8String] );
    
    NSString* patient_id = @"patient_id";
    NSString* series_uid = @"ser_uid";
    NSString* study_uid  = @"study_uid";
    NSString* log_string = @"log_string";
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"<Error> No 2D viewer available";
        LOG_ERROR(Logger, "GetCurrentImageData: {}", [log_string UTF8String] );
    }
    else
    {
        DicomSeries* cs = [currV currentSeries];
        if( cs ) {
            patient_id = [[cs study] patientID];
            study_uid  = [[cs study] studyInstanceUID];
            series_uid = [cs seriesInstanceUID];
        }
        
        DCMPix* curPix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [curPix sourceFile];
    }

    //mutex!
    {
        [Adaptor->Lock lock];
        DicomDataResponse* reply = (DicomDataResponse*)Adaptor->Response;
        if( log_string )
            reply->set_id( std::string([log_string UTF8String]) );
        if( patient_id )
            reply->set_patient_id( [patient_id UTF8String]);
        if( study_uid )
            reply->set_study_instance_uid( [study_uid UTF8String]);
        if( series_uid )
            reply->set_series_instance_uid( [series_uid UTF8String]);
        
        if( arg_string && [arg_string isEqualToString: @"with_file_list"] && currV )
        {
            NSArray* fileList = [currV fileList];
            for(int i=0; i<[fileList count]; i++)
            {
                NSString* path = [[fileList objectAtIndex:i] valueForKey:@"completePath"];
                if( path )
                    reply->add_file_list( [path UTF8String] );
            }
        }
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImageData: %@", log_string]];
    LOG_INFO(Logger, "GetCurrentImageData done with: {}", [log_string UTF8String] );
}

-(NSString*)GetCurrentVersionString
{
    LOG_INFO(Logger, "GetCurrentVersionString..." );
    
    NSString* horos_marketing_version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* horos_build_number      = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString* pyosirix_build_number   = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString* version = [[NSString stringWithFormat:@"Plugin version: %@ [OsiriX/Horos: %@ (%@)]",
                          pyosirix_build_number, horos_marketing_version, horos_build_number] retain];
    
    [horos_build_number release];
    [horos_marketing_version release];
    [pyosirix_build_number release];
    
    return version;
}

-(void)GetCurrentVersion:(NSString *)arg_string {

    LOG_INFO(Logger, "GetCurrentVersion..." );
    
    NSString* log_string = [[self GetCurrentVersionString] retain];
    if( [log_string UTF8String] == nil )
        log_string = @"version_string";
    //mutex!
    {
        if( [Adaptor->Lock tryLock] ) {
            DicomDataRequest* reply = (DicomDataRequest*)Adaptor->Response;
            reply->set_id( std::string([log_string UTF8String]) );
            [Adaptor->Lock unlock];
        }
        else
        {
            [Adaptor->Lock unlock];  // try to clear
            LOG_INFO(Logger, "GetCurrentVersion: ... unlocking");
        }
            
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentVersion: %@", log_string]];
    LOG_INFO(Logger, "GetCurrentVersion: {}", [log_string UTF8String] );
    [log_string release];
}

-(void)GetCurrentImage:(NSString*)arg_string
{
    LOG_INFO(Logger, "GetCurrentImage: {} ...", [arg_string UTF8String] );
    
    NSString* log_string = @"log_string";
    float forigin[3], fvox_size[3], *fraw_data;
    int idim[2];
    uint64 series_addr = 0;
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"<Error> No 2D viewer available";
        LOG_ERROR(Logger, "GetCurrentImage: {}", [log_string UTF8String] );
    }
    else
    {
        /* cf pyOsirix/pyDCMPix.m : pyDCMPix_getImage */
        
        DCMPix* pix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [pix sourceFile];
        
        [pix origin:forigin];
        fvox_size[0] = [pix pixelSpacingX];
        fvox_size[1] = [pix pixelSpacingY];
        fvox_size[2] = [pix spacingBetweenSlices];
        
        //@todo ... maybe these would be better for python the other way around?
        idim[0] = [pix pwidth];
        idim[1] = [pix pheight];
        
        fraw_data = [pix fImage];
        
        DicomSeries* dicom_series = [currV currentSeries];
        series_addr = (uint64)dicom_series;
        [DisplayedSeries addObject:dicom_series];
#if 1
        //test
        NSArray* displ_series = [ViewerController getDisplayedSeries];
        if( displ_series )
        {
            //dump to console using count loop
            for (NSUInteger i = 0; i < displ_series.count; ++i) {
                DicomSeries* s = [displ_series objectAtIndex:i];
                [Console AddText:[NSString stringWithFormat:@"Displayed Study UID: %@ | Series UID: %@ (Patient: %@)",
                                  [[s study] studyInstanceUID], [s seriesInstanceUID], [[s study] patientID] ] ];
            }

            //dump to file using range for loop
            std::ofstream fout("/tmp/series_addr.txt");
            for (NSManagedObject* s in displ_series)
            {
                LOG_INFO(Logger, "Series: {:#x} ", (long long)s );
                fout << "Series: " << " (" << uint64(s) << ") " << std::hex << s << std::endl;
                //            if (s == series)
                //                shown = YES;
                //            if (!shown) {
                //                ViewerController* viewer =
                //                    [[BrowserController currentBrowser] loadSeries:series :NULL :NO keyImagesOnly:NO];
                //                [viewer showWindow:self];
                //            }
            }
        }
#endif
    }

    //mutex!
    {
        [Adaptor->Lock lock];
        ImageGetResponse* reply = (ImageGetResponse*)Adaptor->Response;
        reply->set_id( std::string([log_string UTF8String]) );

        if( currV )
        {
            for( int k=0; k<3; k++ )
            {
                reply->add_origin( forigin[k] );
                reply->add_voxel_size( fvox_size[k] );
            }
            reply->add_image_size( idim[0] );
            reply->add_image_size( idim[1] );
            
            const int n_pixels = idim[0] * idim[1];
            if( fraw_data )
            {
                for( int k=0; k<n_pixels; k++ )
                    reply->add_data( fraw_data[k] );
            }
            
            reply->set_viewer_id(series_addr);
        }
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImage request was: %@", log_string]];
    LOG_INFO( Logger, "GetCurrentImage: {}", [log_string UTF8String] );
}


-(void)SetCurrentImage:(NSString*)arg_string
{
    LOG_INFO(Logger, "SetCurrentImage: {} ...", [arg_string UTF8String] );
    
    NSString* log_string = @"log_string";
    
    float forigin[3], fvox_size[3], *fraw_data;
    int idim[2];
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"<Error>: No 2D viewer available>";
        LOG_ERROR(Logger, "SetCurrentImage: {}", [log_string UTF8String] );
    }
    else
    {
        DCMPix* pix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [pix sourceFile];
        
        [pix origin:forigin];
        fvox_size[0] = [pix pixelSpacingX];
        fvox_size[1] = [pix pixelSpacingY];
        fvox_size[2] = [pix spacingBetweenSlices];
        
        //@todo ... maybe these would be better for python the other way around?
        idim[0] = [pix pwidth];
        idim[1] = [pix pheight];
        
        fraw_data = [pix fImage];
    }

    //mutex!
    {
        [Adaptor->Lock lock];
        ImageSetRequest* request = (ImageSetRequest*)Adaptor->Request;
        ImageSetResponse* reply = (ImageSetResponse*)Adaptor->Response;

        if( currV )
        {
            //if any image params have changed, reject the request
            bool fail = false;
            if( request->image_size(0) != idim[0] ) fail = true;
            if( request->image_size(1) != idim[1] ) fail = true;
            for( int k=0; k<3; k++ )
            {
                if( request->voxel_size(k) != fvox_size[k] ) fail = true;
                if( request->origin(k) != forigin[k] ) fail = true;
            }
            const int n_pixels = idim[0] * idim[1];
            if( !fraw_data || (request->data_size() != n_pixels) ) fail = true;
            if( fail )
            {
                log_string = @"<Error> Image parameter mismatch";
                reply->set_id( std::string([log_string UTF8String]) );
            }
            else
            {
                const auto pdata = request->data();
                for( int k=0; k<n_pixels; k++ )
                    fraw_data[k] = pdata[k];
                
                reply->set_id( std::string([log_string UTF8String]) );
            }
        }
        [Adaptor->Lock unlock];  
        [currV updateImage:nil];
    }
    
    [Console AddText:[NSString stringWithFormat:@"SetCurrentImage: %@", log_string]];
    LOG_INFO( Logger, "SetCurrentImage: {}", [log_string UTF8String] );
}


/*
    This is basically a re-implementation of the ExportROIs plugin to experiment. At present,
    the output is a bunch of csv files to /tmp
 */
-(void)GetROIsAsList:(NSString*) log_string
{
    [Console AddText:[NSString stringWithFormat:@"GetROIsAsList starting... %@", log_string]];

    LOG_INFO(Logger, "GetROIs...");
    ViewerController* viewerController = [ViewerController frontMostDisplayed2DViewer];
    
    NSArray                 *pixList = [viewerController pixList];
    long                    i, j, k, numCsvPoints, numROIs;
    int LF = 0x0a;
    int DQUOTE = 0x22;
            
    // prepare for final output
    NSMutableDictionary        *seriesInfo = [ [ NSMutableDictionary alloc ] init ];
    NSMutableArray            *imagesInSeries = [ NSMutableArray arrayWithCapacity: 0 ];

    NSMutableString    *csvText = [ NSMutableString stringWithCapacity: 100 ];
    [ csvText appendFormat: @"ImageNo,RoiNo,RoiMean,RoiMin,RoiMax,RoiTotal,RoiDev,RoiName,RoiCenterX,RoiCenterY,RoiCenterZ,Length,Area,RoiType,NumOfPoints,mmX,mmY,mmZ,pxX,pxY,...%c", LF ];
    
    NSMutableString *csvRoiPoints;
    
    // get array of arrray of ROI in current series
    NSArray *roiSeriesList = [ viewerController roiList ];
    
    // show progress
    Wait *splash = [ [ Wait alloc ] initWithString: @"Exporting ROIs..." ];
    [ splash showWindow:viewerController ];
    [ [ splash progress] setMaxValue: [ roiSeriesList count ] ];

    // walk through each array of ROI
    for ( i = 0; i < [ roiSeriesList count ]; i++ ) {
        
        // current DICOM pix
        DCMPix *pix = [ pixList objectAtIndex: i ];
        
        // array of ROI in current pix
        NSArray *roiImageList = [ roiSeriesList objectAtIndex: i ];

        NSMutableDictionary *imageInfo = [ [ NSMutableDictionary alloc ] init ];
        NSMutableArray        *roisInImage = [ NSMutableArray arrayWithCapacity: 0 ];

        // walk through each ROI in current pix
        numROIs = [ roiImageList count ];
        for ( j = 0; j < numROIs; j++ ) {
            
            ROI *roi = [ roiImageList objectAtIndex: j ];
            
            NSString *roiName = [ roi name ];
            
            float mean = 0, min = 0, max = 0, total = 0, dev = 0;
            
            [pix computeROI:roi :&mean :&total :&dev :&min :&max];
            
            // array of point in pix coordinate
            NSMutableArray *roiPoints = [ roi points ];
            
            NSMutableDictionary *roiInfo = [ [ NSMutableDictionary alloc ] init ];
            NSMutableArray *mmXYZ = [ NSMutableArray arrayWithCapacity: 0 ];
            NSMutableArray *pixXY = [ NSMutableArray arrayWithCapacity: 0 ];
            NSPoint roiCenterPoint;
            
            // calc center of the ROI
            if ( [ roi type ] == t2DPoint ) {
                // ROI has a bug which causes miss-calculating center of 2DPoint roi
                roiCenterPoint = [ [ roiPoints objectAtIndex: 0 ] point ];
            } else {
                roiCenterPoint = [ roi centroid ];
            }
            float clocs[3], locs[3];
            [ pix convertPixX: roiCenterPoint.x pixY: roiCenterPoint.y toDICOMCoords: clocs ];
            NSString *roiCenter = [ NSString stringWithFormat: @"(%f, %f, %f)", clocs[0], clocs[1], clocs[2] ];

            float area = 0, length = 0;
            NSMutableDictionary    *dataString = [roi dataString];
            
            if( [dataString objectForKey:@"AreaCM2"]) area = [[dataString objectForKey:@"AreaCM2"] floatValue];
            if( [dataString objectForKey:@"AreaPIX2"]) area = [[dataString objectForKey:@"AreaPIX2"] floatValue];
            if( [dataString objectForKey:@"Length"]) length = [[dataString objectForKey:@"Length"] floatValue];
            
            // walk through each point in the ROI
            csvRoiPoints = [ NSMutableString stringWithCapacity: 100 ];
            numCsvPoints = 0;
            for ( k = 0; k < [ roiPoints count ]; k++ ) {
                
                MyPoint *mypt = [ roiPoints objectAtIndex: k ];
                NSPoint pt = [ mypt point ];
                
                [ pix convertPixX: pt.x pixY: pt.y toDICOMCoords: locs ];

                [ mmXYZ addObject: [ NSString stringWithFormat: @"(%f, %f, %f)", locs[0], locs[1], locs[2] ] ];
                NSLog( @"ROI %d - %d (%@): %f, %f, %f", (int)i, (int)j, roiName, locs[0], locs[1], locs[2] );

                //NSArray *pxXY = [ NSArray arrayWithObjects: [ NSNumber numberWithFloat: pt.x ], [ NSNumber numberWithFloat: pt.y ] ];
                //[ xyzInRoi addObject: xyz ];
                [ pixXY addObject: [ NSString stringWithFormat: @"(%f, %f)", pt.x, pt.y ] ];

                // add to csv
                if ( k > 0 ) [ csvRoiPoints appendString: @"," ];
                [ csvRoiPoints appendFormat: @"%f,%f,%f,%f,%f", locs[0], locs[1], locs[2], pt.x, pt.y ];
                numCsvPoints++;
            }
            
            [ csvText appendFormat: @"%d,%d,%f,%f,%f,%f,%f,%c%@%c,%f,%f,%f,%f,%f,%d,%d,%@%c",
             i, j, mean, min, max, total, dev, DQUOTE, roiName, DQUOTE, clocs[0], clocs[1], clocs[2], length, area, [ roi type ], numCsvPoints, csvRoiPoints, LF ];
            
                        
            // roiInfo stands for a ROI
            //   IndexInImage    : order in the pix (start by zero)
            //   Name            : ROI name
            //   Type            : ROI type (in integer)
            //   Center            : center point of the ROI (in mm unit)
            //   NumberOfPoints    : number of points
            //   Point_mm        : array of point (x,y,z) in mm unit
            //   Point_px        : array of point (x,y) in pixel unit
            [ roiInfo setObject: [ NSNumber numberWithLong: j ] forKey: @"IndexInImage" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: mean ] forKey: @"Mean" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: min ] forKey: @"Min" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: max ] forKey: @"Max" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: total ] forKey: @"Total" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: dev ] forKey: @"Dev" ];
            [ roiInfo setObject: roiName forKey: @"Name" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: length ] forKey: @"Length" ];
            [ roiInfo setObject: [ NSNumber numberWithFloat: area ] forKey: @"Area" ];
            [ roiInfo setObject: [ NSNumber numberWithLong: [ roi type ] ] forKey: @"Type" ];
            [ roiInfo setObject: roiCenter forKey: @"Center" ];
            [ roiInfo setObject: [ NSNumber numberWithLong: [ roiPoints count ] ] forKey: @"NumberOfPoints" ];
            [ roiInfo setObject: mmXYZ forKey: @"Point_mm" ];
            [ roiInfo setObject: pixXY forKey: @"Point_px" ];
            
            [ roisInImage addObject: roiInfo ];
        }

        if (numROIs > 0) {
            // imageInfo stands for a DICOM pix
            //   ImageIndex        : order in the series (start by zero)
            //   NumberOfROIs    : number of ROIs
            //   ROIs            : array of ROI
            [ imageInfo setObject: [ NSNumber numberWithLong: i ] forKey: @"ImageIndex" ];
            [ imageInfo setObject: [ NSNumber numberWithLong: numROIs ] forKey: @"NumberOfROIs" ];
            [ imageInfo setObject: roisInImage forKey: @"ROIs" ];
        
            [ imagesInSeries addObject: imageInfo ];
        }
        
        [splash incrementBy: 1];
    }
    
    // seriesInfo stands for a series
    //   Images    : array of imageInfo, which contains array of ROI
    [ seriesInfo setObject: imagesInSeries forKey: @"Images" ];
    NSMutableString *fname = [ NSMutableString stringWithString: @"/tmp/ROI_List" ];
    
    // this creates our csv file
    [ fname appendString: @".csv" ];
    const char *str = [ csvText cStringUsingEncoding: NSASCIIStringEncoding ];
    NSData *data = [ NSData dataWithBytes: str length: strlen( str ) ];
    [ data writeToFile: fname atomically: YES ];

    // this creates an xml file from the dictionary
    [ fname appendString: @".xml" ];
    [ seriesInfo writeToFile: fname atomically: TRUE ];
    [ seriesInfo release ];
    
    // hide progress
    [splash close];
    [splash release];
    
    [Console AddText:[NSString stringWithFormat:@"GetROIsAsList request was: %@", log_string]];
}


-(void)GetROIsAsImage:(NSString*) log_string
{
    [Console AddText:[NSString stringWithFormat:@"GetROIsAsImage starting... %@", log_string]];
    LOG_INFO(Logger, "GetROIsAsImage starting...");

    ViewerController* currV = [ViewerController frontMostDisplayed2DViewer];
    
    NSArray                 *pixList = [currV pixList];
    long                    i, j, numROIs;
            
    // prepare for final output
    NSMutableDictionary        *seriesInfo = [ [ NSMutableDictionary alloc ] init ];
    NSMutableArray            *imagesInSeries = [ NSMutableArray arrayWithCapacity: 0 ];

    // get array of arrray of ROI in current series
    NSArray *roiSeriesList = [ currV roiList ];
    
    DCMPix* starting_pix = [[currV pixList] objectAtIndex: 0];
    std::string tmp_folder( getenv("TMPDIR") );
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy_MM_dd-HH_mm_ss"];
    NSString* date_string = [dateFormatter stringFromDate:[NSDate date]];
    const char* date_utf8 = [date_string UTF8String];

    float forigin[3], fvox_size[3], orient[9];
    int idim[2], num_img = 0;
    if( starting_pix )
    {
        //log_string = [pix sourceFile];
        [starting_pix origin: forigin];
        fvox_size[0] = [starting_pix pixelSpacingX];
        fvox_size[1] = [starting_pix pixelSpacingY];
        fvox_size[2] = [starting_pix spacingBetweenSlices];
        
        //@todo ... maybe these would be better for python the other way around?
        idim[0] = [starting_pix pwidth];
        idim[1] = [starting_pix pheight];
        
        [starting_pix orientation: orient];  // @todo map this to mhd
        
        num_img = [[currV pixList] count];
        
        if( tmp_folder.empty() )
            tmp_folder = "/tmp";
        
        std::string mhd_header( tmp_folder + "/" + date_utf8 + ".mhd" );
        
        [Console AddText:[NSString stringWithFormat:@"Writing mhd header to: %s", mhd_header.c_str()]];
        std::ofstream fmhd_header( mhd_header );
        if( fmhd_header.is_open() )
        {
            fmhd_header << "ObjectType = Image" << std::endl;
            fmhd_header << "NDims = 3" << std::endl;
            fmhd_header << "BinaryData = True" << std::endl;
            fmhd_header << "BinaryDataByteOrderMSB = False" << std::endl;
            fmhd_header << "CompressedData = False" << std::endl;
            fmhd_header << "TransformMatrix = 1 0 0 0 1 0 0 0 1" << std::endl;
            fmhd_header << "Offset = " << forigin[0] << " " << forigin[1] << " " << forigin[2] << std::endl;
            fmhd_header << "CenterOfRotation = 0 0 0" << std::endl;
            fmhd_header << "AnatomicalOrientation = RAI" << std::endl;
            fmhd_header << "ElementSpacing = " << fvox_size[0] << " " << fvox_size[1] << " " << fvox_size[2] << std::endl;
            fmhd_header << "DimSize = " << idim[0] << " " << idim[1] << " " << num_img << std::endl;
            fmhd_header << "ElementType = MET_UCHAR" << std::endl;
            fmhd_header << "ElementDataFile = " << date_utf8 << ".raw" << std::endl;
            fmhd_header.close();
        }
        else
        {
            [Console AddText:[NSString stringWithFormat:@"GetROIsAsImage failed to write mhd header"]];
            LOG_ERROR( Logger, "GetROIsAsImage failed to write mhd header");
        }
    }
    else
    {
        [Console AddText:[NSString stringWithFormat:@"GetROIsAsImage failed to obtain image params"]];
        LOG_ERROR( Logger, "GetROIsAsImage failed to obtain image params");
    }
    
    const size_t SLICE_SIZE = idim[0] * idim[1];
    const size_t NUM_BYTES = SLICE_SIZE * num_img;
    const size_t ROW_SIZE = idim[0];
    const unsigned char FOREGROUND = 255;
    std::vector<unsigned char> vraw_data( NUM_BYTES, (unsigned char)0 );
    unsigned char* raw_data = vraw_data.data();

    
    // CHECK raw_data
    // ==============
    
    // show progress
    Wait *splash = [ [ Wait alloc ] initWithString: @"Exporting ROIs..." ];
    [ splash showWindow:viewerController ];
    [ [ splash progress] setMaxValue: [ roiSeriesList count ] ];

    // walk through each array of ROI
    size_t count = 0;
    for ( i = 0; i < [ roiSeriesList count ]; i++ ) {
        
        const size_t SLICE = i * SLICE_SIZE;
        
        // current DICOM pix
        //DCMPix *pix = [ pixList objectAtIndex: i ];  // this is the image currently selected in the 2D display
        
        // array of ROI in current pix
        NSArray *roiImageList = [ roiSeriesList objectAtIndex: i ];

        NSMutableDictionary *imageInfo = [ [ NSMutableDictionary alloc ] init ];
        NSMutableArray      *roisInImage = [ NSMutableArray arrayWithCapacity: 0 ];

        // walk through each ROI in current pix
        numROIs = [ roiImageList count ];
        for ( j = 0; j < numROIs; j++ ) {
            count++;
            
            ROI *roi = [ roiImageList objectAtIndex: j ];
            
            NSString *roiName = [ roi name ];

            long numberOfValues;
            float* locations = 0;
            float* data = 0;
            [Console AddText:[NSString stringWithFormat:@"Getting ROI for slice: %ld", i ]];
            // need to select the pixel obj for the slice associated with this roi
            DCMPix* roi_pix = [[roi curView] curDCM];
            data = (float*)[roi_pix getROIValue:&numberOfValues :roi :&locations];
            if( locations && data )
            {
                std::ofstream fout( "/tmp/getLineROI+" + std::to_string(i) + "-" + std::to_string(j) + ".csv" );
                if( fout.is_open() )
                {
                    for( size_t k=0; k<numberOfValues; k++ )
                    {
                        const size_t x_ref = (size_t)std::round(locations[2*k]);
                        const size_t y_ref = (size_t)std::round(locations[2*k + 1]);
                        fout << x_ref << ", " << y_ref << ", " << data[k] << std::endl;
                        
                        raw_data[ SLICE + (y_ref * ROW_SIZE) + x_ref ] = (unsigned char)count; //FOREGROUND;
                    }
                    fout.close();
                }
                free( data );
                free( locations );
            }
            [Console AddText:[NSString stringWithFormat:@"Finished getROIValue..."]];
        
        }
        
        [splash incrementBy: 1];
    }
    
    if( raw_data )
    {
        std::ofstream fbin( tmp_folder + "/" + date_utf8 + ".raw", std::ios::out | std::ios::binary );
        if( fbin.is_open() )
        {
            fbin.write( (const char*)raw_data, NUM_BYTES );
            fbin.close();
        }
    }
    
    // hide progress
    [splash close];
    [splash release];
    
    
    [Console AddText:[NSString stringWithFormat:@"GetROIsAsImage done"]];
}




- (void) LogConnection:(NSString*)connec_str
{
    [Console AddText:connec_str];
    
    NSString* version = [[self GetCurrentVersionString] retain];
    if( [version UTF8String] != nil )
        [Console AddText:version];
    [version release];
}

//borrowed from horosplugins/DicomUnEnhancer/Sources/DicomUnEnhancer.mm : _seriesIn(...)
-(void) CollectSeries:(id)obj into:(NSMutableArray*)collection {
    if ([obj isKindOfClass:[DicomSeries class]])
        if (![collection containsObject:obj])
            [collection addObject:obj];

    if ([obj isKindOfClass:[NSArray class]])
        for (id i in obj)
            [self CollectSeries:i into:collection];
    
    if ([obj isKindOfClass:[DicomStudy class]])
        [self CollectSeries:[[(DicomStudy*)obj series] allObjects] into:collection];
    
    if ([obj isKindOfClass:[DicomImage class]])
        [self CollectSeries:[(DicomImage*)obj series] into:collection];
}

@end
