//
//  AppController.h
//  ConsoleApp
//
//  Created by Richard Holbrey on 12/12/2020.
//

#import <Cocoa/Cocoa.h>

@interface AppController : NSObject {
@private
    IBOutlet NSTextField *label;
}

- (IBAction)StartServer:(id)sender;

@end
