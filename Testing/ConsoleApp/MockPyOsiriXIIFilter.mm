//
//  MockPyOsiriXIIFilter.m
//  pyOsiriXII
//
//  Created by Richard Holbrey on 11/12/2020.
//

#import "MockPyOsiriXIIFilter.h"
#include <string>
#include "horos.pb.h"
#include "horos.grpc.pb.h"

#include <png++/png.hpp>

using icr::DicomNameRequest;
using icr::DicomNameResponse;
using icr::DicomImageRequest;
using icr::DicomImageResponse;

@implementation MockPyOsiriXIIFilter

-(id)init
{
    [super init];
    
    //Declare the log window, passing ownership to Manager
    Console = [[ConsoleController alloc] init];

    //Declare the adaptor communication object and pass ownership to Manager
    Adaptor = new icr::ServerAdaptor;
    
    Manager = [[ServerManager alloc] init];
    
    [Manager StartServer:(void*)self
             withAdaptor:Adaptor
             withConsole:Console withPort:@"50051"];
    
    return self;
}

-(void)dealloc
{
    [Manager release];
    [super dealloc];
}

//-(long)filterImage:(NSString*) menuName;

-(void)GetCurrentImageFile:(NSString*) log_string
{
    std::string reply_str("MockPy>GetCurrentImageFile>");

    //mutex!
    {
        [Adaptor->Lock lock];
        const DicomNameRequest* request = (DicomNameRequest*)Adaptor->Request;
        DicomNameResponse* reply = (DicomNameResponse*)Adaptor->Response;
        reply_str.append(request->id());
        reply->set_dicom_name( reply_str );
        [Adaptor->Lock unlock];
    }

    //Have to call gui stuff on the main thread (which may not be case for the mock)
    [(__bridge id)(Adaptor->Osirix)
     performSelectorOnMainThread:@selector(LogConnection:)
     withObject:@"MockPy>GetCurrentImageFile" waitUntilDone:NO];
}


-(void)GetCurrentImage:(NSString*) log_string
{
    log_string = [[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:@"pyosirix.png"];
    NSLog(@"MockPy: GetCurrentImage %@", log_string );
    
    std::string reply_str( [log_string UTF8String] );
    
    png::image<png::gray_pixel> image( [log_string UTF8String] );
    png::image<png::gray_pixel>::pixbuf& buf = image.get_pixbuf();
    
    //mutex!
    {
        [Adaptor->Lock lock];
        DicomImageResponse* reply = (DicomImageResponse*)Adaptor->Response;
        reply->set_dicom_name( reply_str );

        for( int k=0; k<3; k++ )
        {
            reply->add_origin( 0. );
            reply->add_voxel_size( 0. );
        }
        reply->add_image_size( image.get_width() );
        reply->add_image_size( image.get_height() );
        
        for( size_t q=0; q<image.get_height(); q++ )
        {
            for( size_t p=0; p<image.get_width(); p++ )
            {
                reply->add_data( buf.get_pixel(p, q) );
            }
        }
        [Adaptor->Lock unlock];
    }
    
    [(__bridge id)(Adaptor->Osirix)
     performSelectorOnMainThread:@selector(LogConnection:)
     withObject: [NSString stringWithFormat:@"MockPy>GetCurrentImageFile>%@", log_string]
     waitUntilDone:NO];
    
}


-(void)LogConnection:(NSString*) connec_str
{
    NSLog(@"MockPy: LogConnection %@", connec_str );
    [Console AddText:connec_str];
}

@end
