/*=========================================================================
  Program:   OsiriX

  Copyright (c) OsiriX Team
  All rights reserved.
  Distributed under GNU - LGPL
  
  See http://www.osirix-viewer.com/copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.
=========================================================================*/

#import <Cocoa/Cocoa.h>
#import "dicomFile.h"

/** \brief  C++ calls for DicomFile 
*
*  Some C++ header from DCMTK and other C++ libs can conflict with Objective C during compilation.
*  Putting them in a separate category prevents compilation errors.
*/

@interface DicomFile (DicomFileDCMTKCategory)

+ (NSArray*) getEncodingArrayForFile: (NSString*) file;
+ (BOOL) isDICOMFileDCMTK:(NSString *) file; /**< Check for validity of DICOM using DCMTK */
+ (BOOL) isNRRDFile:(NSString *) file; /**< Test for NRRD file format */
+ (NSString*) getDicomField: (NSString*) field forFile: (NSString*) path;
+ (NSString*) getDicomFieldForGroup:(int)gr element:(int)el forFile: (NSString*) path;
+ (NSString*) getDicomFieldForGroup:(int) gr element: (int) el forDcmFileFormat: (void*) ff;
+ (BOOL) rewriteAsExplicit:(NSString*) path; /**< This can clean corrupted file / fields */
+ (unsigned short) getVRForElement: (unsigned short) el group: (unsigned short) gr;

- (BOOL) getHologicHeader;
- (short) getDicomFileDCMTK; /**< Decode DICOM using DCMTK.  Returns 0 on success -1 on failure. */
- (short) getNRRDFile; /**< decode NRRD file format.  Returns 0 on success -1 on failure. */
- (NSDictionary*) presentationStateDictionaries;
@end
