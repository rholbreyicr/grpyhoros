//
//  ImageHelper.cpp
//  grpyHoros
//
//  Created by Richard Holbrey on 25/05/2022.
//

#import "ImageHelper.h"
#import <OsiriXAPI/DCMPix.h>



@implementation ImageHelper

-(id)init {
    if (self = [super init]) {
        // Initialize self
    }
    return self;
}

- (void) dealloc {
    
    [super dealloc];
}

- (bool) getDicomParameters: (NSString *) dcm_file
                        dim: (int *) dim
                     pixdim: (float *) pixdim
                     origin: (float *) origin
                orientation: (int *) orientation
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // slices orientation
    orientation[0] = 1;
      
    DCMObject *dcmObject = [DCMObject objectWithContentsOfFile:dcm_file decodingPixelData:NO];
    
    if(!dcmObject)
    {
        //NSLog( @"Error when reading the dcm file %@\n", dcmFile);
        return false;
    }
    else
    {
        
        /* Read information about the DICOM volume     */
        long x, y, z;
        float xSpacing, ySpacing, zSpacing, oX, oY, oZ;
        xSpacing = ySpacing = zSpacing = 1;
        oX = oY = oZ = 0;
        
        float z1, z2;
        z1 = z2 = 0;
        
        NSArray *ipp1 = [dcmObject attributeArrayWithName:@"ImagePositionPatient"];
        if( ipp1 )
        {
            z1 = [[ipp1 objectAtIndex:2] floatValue];
           
//            if (z2 < z1)
//            {
//                orientation[0] = 0; //the slices are oriented following the decreasing z
//                NSLog(@"The slices are oriented following the decreasing z");
//            }
//            else
//                NSLog(@"The slices are oriented following the increasing z");
        }
            

        
        // orientation
        NSArray *ipp = [dcmObject attributeArrayWithName:@"ImagePositionPatient"];
        if( ipp )
        {
            oX = [[ipp objectAtIndex:0] floatValue];
            oY = [[ipp objectAtIndex:1] floatValue];
        }
        
        // image size
        if( [dcmObject attributeValueWithName:@"Rows"])
        {
            y = [[dcmObject attributeValueWithName:@"Rows"] intValue];
            //y /= 2;
            //y *= 2;
        }
        
        if( [dcmObject attributeValueWithName:@"Columns"])
        {
            x =  [[dcmObject attributeValueWithName:@"Columns"] intValue];
            //x /= 2;
            //x *= 2;
        }
        
        
        //pixel Spacing
        NSArray *pixelSpacing = [dcmObject attributeArrayWithName:@"PixelSpacing"];
        if(pixelSpacing.count >= 2 )
        {
            xSpacing = [[pixelSpacing objectAtIndex:0] floatValue];
            ySpacing = [[pixelSpacing objectAtIndex:1] floatValue];
        }
        else if(pixelSpacing.count >= 1 )
        {
            xSpacing = [[pixelSpacing objectAtIndex:0] floatValue];
            ySpacing = [[pixelSpacing objectAtIndex:0] floatValue];
        }
        else
        {
            NSArray *pixelSpacing = [dcmObject attributeArrayWithName:@"ImagerPixelSpacing"];
            if(pixelSpacing.count >= 2 )
            {
                xSpacing = [[pixelSpacing objectAtIndex:0] floatValue];
                ySpacing = [[pixelSpacing objectAtIndex:1] floatValue];
            }
            else if(pixelSpacing.count >= 1 )
            {
                xSpacing = [[pixelSpacing objectAtIndex:0] floatValue];
                ySpacing = [[pixelSpacing objectAtIndex:0] floatValue];
            }
        }
        
        
        if( [dcmObject attributeValueWithName:@"SliceThickness"])
            zSpacing = [[dcmObject attributeValueWithName:@"SliceThickness"] floatValue]; // sliceThickness or spacingBetweenSlice
        
        // save the dimensions
        dim[0] = x;
        dim[1] = y;
        dim[2] = z;
        
        pixdim[0] = xSpacing;
        pixdim[1] = ySpacing;
        pixdim[2] = zSpacing;
        
        origin[0] = oX;
        origin[1] = oY;
        
        //NSLog(@"Dimensions x %d, y %d, z %d, xspace %f yspace %f zspace %f, oX %f, oY %f", x, y, z, xSpacing, ySpacing, zSpacing, oX, oY);
        
        
        /* Create a 3d volume */

//        float val[x*y];
//        int tmp, slice;
//        for (tmp = 0; tmp < x*y; tmp++)
//            val[tmp] = 0;
//
//        for (slice = 0; slice < z ; slice++)
//        {
//            DCMPix *myPix = [[DCMPix alloc] initwithdata:val :32 :x :y :xSpacing :ySpacing :oX :oY: oZ ];
//            [dcmPixList addObject:myPix];
//            [myPix release];
//        }
    }
    
    [pool release];
    return true;
}

@end

