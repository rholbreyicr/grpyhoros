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
using pyosirix::ROIRequest;
using pyosirix::ROIResponse;

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
        reply->set_id( std::string([log_string UTF8String]) );
        reply->set_patient_id( [patient_id UTF8String]);
        reply->set_study_instance_uid( [study_uid UTF8String]);
        reply->set_series_instance_uid( [series_uid UTF8String]);
        
        if( [arg_string isEqualToString: @"with_file_list"] && currV )
        {
            NSArray* fileList = [currV fileList];
            for(int i=0; i<[fileList count]; i++)
            {
                NSString* path = [[fileList objectAtIndex:i] valueForKey:@"completePath"];
                reply->add_file_list( [path UTF8String] );
            }
        }
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImageData: %@", log_string]];
    LOG_INFO(Logger, "GetCurrentImageData: {}", [log_string UTF8String] );
}

-(NSString*)GetCurrentVersionString
{
    NSString* horos_marketing_version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* horos_build_number      = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString* pyosirix_build_number   = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString* version = [[NSString stringWithFormat:@"plugin version: %@ [OsiriX/Horos: %@ (%@)]",
                          pyosirix_build_number, horos_marketing_version, horos_build_number] retain];
    
    [horos_build_number release];
    [horos_marketing_version release];
    [pyosirix_build_number release];
    
    return version;
}

-(void)GetCurrentVersion:(NSString *)arg_string {

    NSString* log_string = [[self GetCurrentVersionString] retain];
    if( [log_string UTF8String] == nil )
        log_string = @"version_string";
    //mutex!
    {
        [Adaptor->Lock lock];
        DicomDataRequest* reply = (DicomDataRequest*)Adaptor->Response;
        reply->set_id( std::string([log_string UTF8String]) );
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentVersion: %@", log_string]];
    LOG_INFO(Logger, "GetCurrentVersion: {}", [log_string UTF8String] );
    [log_string release];
}

-(void)GetCurrentImage:(NSString*)arg_string
{
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


-(void)GetSelectedROI:(NSString *)log_string {
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    ROI* selectedROI = nil;
    
    NSString *roiName = @"roi";
    NSMutableArray* pts = nil;

    float roiThickness = 0.f;
    unsigned int red = 0;
    unsigned int green = 0;
    unsigned int blue = 0;
    
    if( !currV )
    {
        log_string = @"Error: <No 2D viewer available>";
    }
    else
    {
        selectedROI = [currV selectedROI];
        if( selectedROI )
        {
            roiName = [selectedROI name];
            roiThickness = [selectedROI thickness];
            RGBColor roiColor = [selectedROI rgbcolor];
            red = roiColor.red;
            green = roiColor.green;
            blue = roiColor.blue;
            
            pts = [selectedROI points];
            log_string = @"GetSelectedROI: set roi params";
        }
    }
    
//    NSString *key = [self keyForObject:sROI];
//    // Already contined in objects?
//    if (!key)
//    {
//        key = [[NSUUID UUID] UUIDString];
//        [grpcObjects setValue:sROI forKey:key];
//        NSString *rep = [NSString stringWithFormat:@"Key not found, %lu", [grpcObjects count]];
//        [Console AddText:rep];
//    }
//    else
//    {
//        [Console AddText:@"Key IS found!"];
//    }
//
//    std::string key_str( [key UTF8String] );
    
    //mutex!
    {
        [Adaptor->Lock lock];
        ROIRequest* request = (ROIRequest*)Adaptor->Request;
        ROIResponse* reply = (ROIResponse*)Adaptor->Response;
        reply->set_id(request->id());
        reply->set_name([roiName UTF8String]);
        reply->set_thickness(roiThickness);
        reply->mutable_color()->set_r(red);
        reply->mutable_color()->set_g(green);
        reply->mutable_color()->set_b(blue);
        
        if( pts )
        {
            for( size_t k=0; k<[pts count]; k++ )
            {
                NSPoint* roi_pt = (NSPoint*)[pts objectAtIndex:k];
                auto pt = reply->mutable_points()->Add();
                pt->set_x(roi_pt->x);
                pt->set_y(roi_pt->y);
            }
        }
        [Adaptor->Lock unlock];
    }

    [Console AddText:[NSString stringWithFormat:@"GetSelectedROI: %@", log_string]];
    LOG_INFO( Logger, "GetSelectedROI: {}", [log_string UTF8String] );
}

#if 0
-(void)UpdateROI:(NSString *)log_string {
    
    //mutex!
    {
        [Adaptor->Lock lock];
        icr::ROI* roi = (icr::ROI*)Adaptor->Request;
        icr::UpdateROIResponse *reply = (icr::UpdateROIResponse *)Adaptor->Response;
        short int red = roi->mutable_color()->r();
        short int green = roi->mutable_color()->g();
        short int blue = roi->mutable_color()->b();
        NSString * name = [NSString stringWithCString:roi->name().c_str() encoding:[NSString defaultCStringEncoding] ];
        NSString * key = [NSString stringWithCString:roi->id().c_str() encoding:[NSString defaultCStringEncoding] ];
        float thickness = roi->thickness();
        
        ROI* osirixROI = [grpcObjects objectForKey:key];
        if (!osirixROI)
        {
            log_string = @"Error: ROI no longer available";
        }
        else{
            ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
            RGBColor rgb;
            rgb.red = red;
            rgb.green = green;
            rgb.blue = blue;
            [osirixROI setColor:rgb];
            [osirixROI setName:name];
            [osirixROI setThickness:thickness];
            [currV needsDisplayUpdate];
        }
        std::string reply_str( [log_string UTF8String] );
        reply->set_message(reply_str);
        [Adaptor->Lock unlock];
    }

    [Console AddText:[NSString stringWithFormat:@"GetCurrentImageFile: %@", log_string]];
}


#endif


- (void) LogConnection:(NSString*)connec_str
{
    [Console AddText:connec_str];

    // would like to add this but frequently crashes (? ... VersionString has random contents)
    //[Console AddText:VersionString];
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
