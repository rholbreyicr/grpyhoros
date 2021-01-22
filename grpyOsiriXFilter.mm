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

using icr::DicomNameRequest;
using icr::DicomNameResponse;
using icr::ImageGetRequest;
using icr::ImageGetResponse;
using icr::ImageSetRequest;
using icr::ImageSetResponse;

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
    
    [self StartLogger];
}

- (void) dealloc {
    
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
        log_file_name, "a", "daily", 1, 10, quill::Timezone::LocalTime, "01:00" ) );
    
    LogHandler->set_log_level(quill::LogLevel::Info);

    // Create a logger using this handler
    Logger.reset( quill::create_logger("day_log", LogHandler.get()) );
    
    //quill::Logger* logger = quill::get_logger();
    LOG_INFO(Logger, "Initializing grpyHoros:OsiriX...{}", " let's hope all goes well" );
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
    Adaptor = new icr::ServerAdaptor;
    
    Manager = [[ServerManager alloc] init];

    [Manager StartServer:(void*)self
             withAdaptor:Adaptor
             withConsole:Console withPort:@"50051"];
}


-(void)GetCurrentImageFile:(NSString*) log_string {
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"<Error> No 2D viewer available";
        LOG_ERROR(Logger, "GetCurrentImageFile: {}", [log_string UTF8String] );
    }
    else
    {
        DCMPix* curPix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [curPix sourceFile];
    }

    //mutex!
    {
        [Adaptor->Lock lock];
        DicomNameResponse* reply = (DicomNameResponse*)Adaptor->Response;
        reply->set_id( std::string([log_string UTF8String]) );
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImageFile: %@", log_string]];
    LOG_INFO(Logger, "GetCurrentImageFile: {}", [log_string UTF8String] );
}

//get all file names
//    //DicomImage* dcm = [currV currentImage];
//    NSArray* fileList = [currV fileList];
//    std::ofstream fout("/tmp/files.txt");
//    for(int ii=0; ii<[fileList count]; ii++)
//    {
//        NSString* path = [[fileList objectAtIndex:ii] valueForKey:@"completePath"];
//        printf( "File %d: %s \n", ii, [path UTF8String] );
//
//        fout << "File " << ii << " " << [path UTF8String] << std::endl;
//    }
//    fout.close();
//}

-(void)GetCurrentImage:(NSString*) log_string
{
    BrowserController* browser = [BrowserController currentBrowser];
    [browser selectedStudies];
    
    float forigin[3], fvox_size[3], *fraw_data;
    int idim[2];
    
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
        }
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImage request was: %@", log_string]];
    LOG_INFO( Logger, "GetCurrentImage: {}", [log_string UTF8String] );
}


-(void)SetCurrentImage:(NSString*) log_string
{
    
    
    
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

- (void) LogConnection:(NSString*)connec_str
{
    [Console AddText:connec_str];
}

@end
