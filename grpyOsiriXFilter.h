//
//  PluginTemplateFilter.h
//  PluginTemplate
//
//  Copyright (c) CURRENT_YEAR YOUR_NAME. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PluginFilter.h"
#import "ServerManager.h"

@interface grpyOsiriXFilter : PluginFilter {
    ServerManager* Manager;       ///< Manage and start the server thread (we are the owner)
    ConsoleController* Console;   ///< Console window (owned by Manager)
    icr::ServerAdaptor* Adaptor;  ///< Communication adaptor reference (between the server thread and above;
                                  ///< owned by Manager)
}

-(void)dealloc;

/**
    \brief filterImage plugin defined entry function
 */
-(long)filterImage:(NSString*) menuName;

-(void)StartServer;

-(void)GetCurrentImageFile:(NSString*) log_string;
-(void)GetCurrentImage:(NSString*) log_string;
-(void)SetCurrentImage:(NSString*) log_string;
-(void)LogConnection:(NSString*) connec;

@end
