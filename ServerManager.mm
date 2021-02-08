//
//  ServerManager.m
//  ConsoleApp
//
//  Created by Richard Holbrey on 12/12/2020.
//

#import "ServerManager.h"
#import "HorosServer.h"


//-----------------------------------------------------------------------------------

@implementation ServerManager

-(id)init {
    if (self = [super init]) {
        // Initialize self
    }
    return self;
}

- (void) dealloc {

    [Adaptor->Lock release];
    [Console release];
    if( Adaptor ) delete Adaptor;
    [super dealloc];
}

-(void)StartServer:(void*)plugin_filter
       withAdaptor:(pyosirix::ServerAdaptor*)adaptor
       withConsole:(ConsoleController*)console
       withPort:(NSString*)port
{
    //Start the log window
    if( !console )
        Console = [[ConsoleController alloc] init /*WithWindowNibName:@"ConsoleController" owner:self*/ ];
    else
        Console = console;
        
    NSWindow* console_window = [Console window];
    [console_window makeKeyAndOrderFront:self];
    Console.LogViewFR = (NSTextView*)[console_window firstResponder];
    [Console.LogViewFR setEditable:NO];
    [Console.LogViewFR setDrawsBackground:YES];
    [Console.LogViewFR setBackgroundColor:NSColor.blackColor];
    [Console.LogViewFR setTextColor:NSColor.greenColor];
    //Note: Console is now seen to be owned by this class
    
    //Initialize the communication object
    Adaptor = adaptor;
    if( !Adaptor )
        Adaptor = new pyosirix::ServerAdaptor;
    Adaptor->Osirix = (void*)plugin_filter;
    
    if( port.length == 0 )
        strcpy( Adaptor->Port, "50051" );
    else
        strcpy( Adaptor->Port, [port UTF8String] );
    
    Adaptor->Lock = [[[NSLock alloc] init] retain];
    Adaptor->Request = NULL;
    Adaptor->Response = NULL;
        
    // Start the server communication thread
    // block code borrowed from:
    // horosplugins/HipArthroplastyTemplating/Sources/ArthroplastyTemplatingStepsController.mm
    [NSThread detachNewThreadSelector:(@selector(SpawnThread))
                             toTarget:(id)self withObject:nil];
    
}



 
-(void)SpawnThread
{
    pyosirix::HorosServer::RunServer( (void*)Adaptor );
}
 
@end
