//
//  ConsoleController.h
//  pyOsiriXII
//
//  Created by Richard Holbrey on 29/11/2020.
//

#import <Cocoa/Cocoa.h>


NS_ASSUME_NONNULL_BEGIN

@interface ConsoleController : NSWindowController

@property (strong) NSTextView* LogViewFR;
@property (strong) IBOutlet NSTextView* LogView;


- (id)init;
- (void)dealloc;

- (IBAction)ClearText:(id)sender;
- (void)AddText:(NSString*)str;


@end

NS_ASSUME_NONNULL_END
