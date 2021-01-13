//
//  MockPyOsiriXIIFilter.h
//  pyOsiriXII
//
//  Created by Richard Holbrey on 11/12/2020.
//

#import <Foundation/Foundation.h>
#import "ConsoleController.h"
#import "ServerAdaptor.h"
#import "ServerManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockPyOsiriXIIFilter : NSObject
{
    ServerManager* Manager;       ///< Manage and start the server thread (we are the owner)
    ConsoleController* Console;   ///< Console window reference (owned by Manager)
    icr::ServerAdaptor* Adaptor;  ///< Communication adaptor reference (between the server thread and above;
                                  ///< owned by Manager)
}

-(id)init;
-(void)dealloc;


/** \brief GetCurrentImageFile
           Mock by simply returning the id string
 */
-(void)GetCurrentImageFile:(NSString*) log_string;

-(void)GetCurrentImage:(NSString*) log_string;
-(void)LogConnection:(NSString*) connec_str;


@end

NS_ASSUME_NONNULL_END
