//
//  ServerManager.h
//  pyOsiriXII
//
//  Created by Richard Holbrey on 12/12/2020.
//

#import <Foundation/Foundation.h>
#import "ServerAdaptor.h"
#import "ConsoleController.h"

@interface ServerManager : NSObject {
@public
    icr::ServerAdaptor* Adaptor;  ///< Communication adaptor reference (we are the owner)
    ConsoleController* Console;   ///< Console window (owned by Manager)
}

-(id)init;
-(void)dealloc;

-(void)StartServer:(void*)plugin_filter
       withAdaptor:(icr::ServerAdaptor*)adaptor
       withConsole:(ConsoleController*)console
       withPort:(NSString*)port;

//make private ??
-(void)SpawnThread;

@end

