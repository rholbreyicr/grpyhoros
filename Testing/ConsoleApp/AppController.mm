//
//  AppController.m
//  ConsoleApp
//
//  Created by Richard Holbrey on 12/12/2020.
//

#import "AppController.h"
#import "MockPyOsiriXIIFilter.h"

@implementation AppController

- (IBAction)StartServer:(id)sender
{
    label.stringValue = @"Running.....";
    
    MockPyOsiriXIIFilter* mock_plugin = [[MockPyOsiriXIIFilter alloc] init];
    
    
}

@end
