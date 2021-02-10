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

/**
    \brief filterImage
           plugin API defined entry function
 */
-(long)filterImage:(NSString*) menuName;

/**
 \brief StartServer
        Start the grpc server running on a separate thread
 */
-(void)StartServer;

/**
 \brief StartLogger
        Start the quill logger running
 */
-(void)StartLogger;

/**
 \brief GetCurrentVersionString
        Get the current version of the software (plugin & host) as a string
 \@param version
        The software version number/names or dummy string on error
 */
-(NSString*)GetCurrentVersionString;

-(void)LogConnection:(NSString*) connec;
-(void)CollectSeries:(id)obj into:(NSMutableArray*)collection;

//rpc commands
-(void)GetCurrentImageData:(NSString*) arg_string;
-(void)GetCurrentVersion:(NSString*) arg_string;
-(void)GetCurrentImage:(NSString*) arg_string;
-(void)SetCurrentImage:(NSString*) arg_string;

//-(void)GetSelectedROI:(NSString*) log_string;
//-(void)UpdateROI:(NSString*) log_string;

@end
