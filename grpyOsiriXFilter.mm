//
//  PluginTemplateFilter.m
//  PluginTemplate
//
//  Copyright (c) CURRENT_YEAR YOUR_NAME. All rights reserved.
//

#import "grpyOsiriXFilter.h"
#import "ServerAdaptor.h"

#include "horos.pb.h"
#include "horos.grpc.pb.h"

#include <fstream>

using icr::DicomNameRequest;
using icr::DicomNameResponse;
using icr::ImageGetRequest;
using icr::ImageGetResponse;

//-----------------------------------------------------------------------------------

@implementation grpyOsiriXFilter

- (void) initPlugin
{
    if( [NSThread isMultiThreaded] )
    {
        NSLog( @"<pyOsiriXii> is threaded\n" );
    }
    else
    {
        // Initialize Cocoa threads .... needed even if using posix threads
        // We would expect Horos/OsiriX to be threaded anyway but.....
        // *** Note this just crashes the plugin or breaks loading ***
        //[NSThread detachNewThreadSelector:@selector(dummyFunc:) toTarget:[Dummy alloc] withObject:nil];
        //clean up
    }
}

- (void) dealloc {
    
    [Manager release];    
    [super dealloc];
}

- (long) filterImage:(NSString*) menuName
{
    [self StartServer];
    
     return 0;
}

-(void)StartServer
{
    //Declare the log window, passing ownership to Manager
    Console = [[ConsoleController alloc] init];

    //Declare the adaptor communication object and pass ownership to Manager
    Adaptor = new icr::ServerAdaptor;
    
    Manager = [[ServerManager alloc] init];

    [Manager StartServer:(void*)self
             withAdaptor:Adaptor
             withConsole:Console withPort:@"50051"];
}


-(void)GetCurrentImageFile:(NSString*) log_string {
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"Error: <No 2D viewer available>";
    }
    else
    {
        DCMPix* curPix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [curPix sourceFile];
    }
    std::string reply_str( [log_string UTF8String] );

    //mutex!
    {
        [Adaptor->Lock lock];
        DicomNameResponse* reply = (DicomNameResponse*)Adaptor->Response;
        reply->set_dicom_name( reply_str );
        [Adaptor->Lock unlock];
    }

    [Console AddText:[NSString stringWithFormat:@"GetCurrentImageFile: %@", log_string]];
}

//get all file names
//    //DicomImage* dcm = [currV currentImage];
//    NSArray* fileList = [currV fileList];
//    std::ofstream fout("/tmp/files.txt");
//    for(int ii=0; ii<[fileList count]; ii++)
//    {
//        NSString* path = [[fileList objectAtIndex:ii] valueForKey:@"completePath"];
//        printf( "File %d: %s \n", ii, [path UTF8String] );
//
//        fout << "File " << ii << " " << [path UTF8String] << std::endl;
//    }
//    fout.close();
//}

-(void)GetCurrentImage:(NSString*) log_string
{
    float forigin[3], fvox_size[3], *fraw_data;
    int idim[2];
    
    ViewerController *currV = [ViewerController frontMostDisplayed2DViewer];
    if( !currV )
    {
        log_string = @"Error: <No 2D viewer available>";
    }
    else
    {
        DCMPix* curPix = [[currV pixList] objectAtIndex: [[currV imageView] curImage]];
        log_string = [curPix sourceFile];
        
        [curPix origin:forigin];
        fvox_size[0] = [curPix pixelSpacingX];
        fvox_size[1] = [curPix pixelSpacingY];
        fvox_size[2] = [curPix spacingBetweenSlices];
        
        //@todo ... maybe these would be better for python the other way around?
        idim[0] = [curPix pwidth];
        idim[1] = [curPix pheight];
        
        fraw_data = [curPix fImage];
    }
    std::string reply_str( [log_string UTF8String] );

    /* from pyOsirix/pyDCMPix.m
    
     DCMPix *pix = self->obj;
     long w = [pix pwidth];
     long h = [pix pheight];
     
     init_numpy_DCMPix();
     PyArrayObject *image = NULL;
     npy_intp dims[2] = {w,h};
     npy_intp strides[2] = {sizeof(float), w*sizeof(float)};
     image = (PyArrayObject *)PyArray_New(&PyArray_Type, 2, dims, NPY_FLOAT, strides, NULL, sizeof(float), NPY_ARRAY_CARRAY, NULL);
     float * data = (float *)PyArray_DATA(image);
     float *osirixData = [pix fImage];
     memcpy(data, osirixData, w*h*sizeof(float));
     
    */

    //mutex!
    {
        [Adaptor->Lock lock];
        ImageGetResponse* reply = (ImageGetResponse*)Adaptor->Response;
        reply->set_dicom_name( reply_str );

        if( currV )
        {
            for( int k=0; k<3; k++ )
            {
                reply->add_origin( forigin[k] );
                reply->add_voxel_size( fvox_size[k] );
            }
            reply->add_image_size( idim[0] );
            reply->add_image_size( idim[1] );
            
            const int n_pixels = idim[0] * idim[1];
            if( fraw_data )
            {
                for( int k=0; k<n_pixels; k++ )
                    reply->add_data( fraw_data[k] );
            }
        }
        [Adaptor->Lock unlock];
    }
    
    [Console AddText:[NSString stringWithFormat:@"GetCurrentImage request was: %@", log_string]];
}

- (void) LogConnection:(NSString*)connec_str
{
    [Console AddText:connec_str];
}

@end
