//
//  ConsoleController.m
//  pyOsiriXII
//
//  Created by Richard Holbrey on 29/11/2020.
//

#import "ConsoleController.h"

@interface ConsoleController ()

@end

@implementation ConsoleController

- (id)init
{
    //see /Users/rholbrey/imaging/src/horosplugins/OSIDemoPlugin/OSIDemoPlugin/OSIDemoWindowController.m
    if ( (self = [super initWithWindowNibName:@"ConsoleController"] ) ) {

        [self retain]; // ????
    }
    return self;
}


- (void)dealloc {
    [_LogView release];
    [_LogViewFR release]; // should be pointing at same obj as _LogView
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    //logger = is initialized when NIB loaded
    //LogView is assigned by plugin filter (via first responder) .... Note should be pointing to same thing as logger
}

-(IBAction)ClearText:(id)sender {

    [_LogView setString: @""];
}

-(void)AddText:(NSString*)str {

    NSDate *currDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"[YY.MM.dd HH:mm:ss]"];
    NSString* dateString = [dateFormatter stringFromDate:currDate];
    [dateFormatter release];
    //NSLog(@"%@",dateString);
    
    if( [_LogViewFR.string length] == 0 )
        [_LogViewFR setString:[NSString stringWithFormat:@"%@ %@\n", dateString, str]];
    else {
        [_LogViewFR setString:[NSString stringWithFormat:@"%@\n%@ %@", [_LogViewFR string], dateString, str]];
        [_LogViewFR scrollRangeToVisible:NSMakeRange([[_LogViewFR string] length], 0)];
    }
}

@end
