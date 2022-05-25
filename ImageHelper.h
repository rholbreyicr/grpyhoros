//
//  ImageHelper.h
//  grpyHoros
//
//  Created by Richard Holbrey on 25/05/2022.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject {
@public


}

-(id)init;
-(void)dealloc;

/**
    @brief getDicomParameters: get dicom parameters from the file dcm_file
        @param dim[2] width and height of the image
        @param pixdim[3] pixel spacing (X/Y) and slice thickness (note: this can sometimes be in error)
        @param origin[3] origin of image, in mm (usually)
        @param orientation...
 
        Note: partly borrowed from Inria's CreateROIMask routine 'createVolume'
 */
- (bool) getDicomParameters: (NSString *) dcm_file
                        dim: (int *) dim
                     pixdim: (float *) pixdim
                     origin: (float *) origin
                orientation: (int *) orientation;

@end
