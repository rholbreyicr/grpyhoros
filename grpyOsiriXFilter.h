//
//  PluginTemplateFilter.h
//  PluginTemplate
//
//  Copyright (c) CURRENT_YEAR YOUR_NAME. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PluginFilter.h"
#import "ServerManager.h"

#include <quill/Quill.h>
#import <OsiriXAPI/MyPoint.h>


/**
 @brief grpyOsiriXFilter
        Plugin entry point class and interface handler.
 
        The class handles the initial setup, starts the grpc server and then
        handles server requests (which generally have to be on the main thread)
 */
@interface grpyOsiriXFilter : PluginFilter {
    ServerManager* Manager;       ///< Manage and start the server thread (we are the owner)
    ConsoleController* Console;   ///< Console window (owned by Manager)
    pyosirix::ServerAdaptor* Adaptor;  ///< Communication adaptor reference (between the server thread and above;
                                       ///< owned by Manager)
    
    //NSMutableDictionary *grpcObjects = [[NSMutableDictionary alloc] init];
    NSMutableArray* DisplayedSeries;
     
    std::shared_ptr<quill::Handler> LogHandler;
    std::shared_ptr<quill::Logger> Logger;
}

-(void)dealloc;

/** plugin API defined entry function */
-(long)filterImage:(NSString*) menuName;

/** Start the grpc server running on a separate thread */
-(void)StartServer;

/** Start the quill logger running */
-(void)StartLogger;

/** Get the current version of the software (plugin & host) as a string */
-(NSString*)GetCurrentVersionString;

/** Log the grpc server connection is running  */
-(void)LogConnection:(NSString*) connec;

/** Collect all DicomSeries of a given DicomStudy (or set of DicomStudy objects) into a collection */
-(void)CollectSeries:(id)obj into:(NSMutableArray*)collection;

/** Get metadata for the current displayed image in the host. If 'with_file_list' is supplied as the string
 arg, the source image list is also returned */
-(void)GetCurrentImageData:(NSString*) arg_string;

/** Get the current plugin/host software versions */
-(void)GetCurrentVersion:(NSString*) arg_string;

/** Get the current displayed image (including pixel data) in the host in a displayable format */
-(void)GetCurrentImage:(NSString*) arg_string;

/** Set the current displayed image (including pixel data) in the host using a previously retrieved image */
-(void)SetCurrentImage:(NSString*) arg_string;

/** Get the ROIs in the currently selected slice */
-(void)GetSliceROIs:(NSString*) log_string;
//-(void)UpdateROI:(NSString*) log_string;

@end
