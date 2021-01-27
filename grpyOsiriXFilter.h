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
    icr::ServerAdaptor* Adaptor;  ///< Communication adaptor reference (between the server thread and above;
                                  ///< owned by Manager)
    
    std::shared_ptr<quill::Handler> LogHandler;
    std::shared_ptr<quill::Logger> Logger;
}

-(void)dealloc;

/**
    \brief filterImage plugin defined entry function
 */
-(long)filterImage:(NSString*) menuName;

-(void)StartServer;
-(void)StartLogger;

-(void)LogConnection:(NSString*) connec;
-(void)CollectSeries:(id)obj into:(NSMutableArray*)collection;

-(void)GetCurrentImageFile:(NSString*) log_string;
-(void)GetCurrentImage:(NSString*) log_string;
-(void)SetCurrentImage:(NSString*) log_string;

@end
