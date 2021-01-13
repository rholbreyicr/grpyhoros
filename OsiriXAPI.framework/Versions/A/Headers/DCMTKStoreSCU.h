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

#import "DICOMTLS.h"
#import "DDKeychain.h"

int runStoreSCU(const char *myAET, const char*peerAET, const char*hostname, int port, NSDictionary *extraParameters);

/** \brief  DICOM Send 
*
* DCMTKStoreSCU performs the DICOM send
* based on DCMTK 
*/
@interface DCMTKStoreSCU : NSObject {
	BOOL _threadStatus;
	
	NSString *_callingAET;
	NSString *_calledAET;
	int _port;
	NSString *_hostname;
	NSDictionary *_extraParameters;
	int _transferSyntax;
	float _compression;
    
    int _maxThreads;
	NSMutableArray *_filesToSend;
	int _numberOfFiles;
	int _numberSent;
	int _numberErrors;
	NSString *_patientName;
	NSString *_studyDescription; 
	id _logEntry;
	
	//TLS settings
	BOOL _secureConnection;
	BOOL _doAuthenticate;
	int  _keyFileFormat;
	NSArray *_cipherSuites;
	const char *_readSeedFile;
	const char *_writeSeedFile;
	TLSCertificateVerificationType certVerification;
	const char *_dhparam;	
}

@property int maxThreads;

+ (int) sendSyntaxForListenerSyntax: (int) listenerSyntax;
- (id) initWithCallingAET:(NSString *)myAET
                calledAET:(NSString *)theirAET
                 hostname:(NSString *)hostname
                     port:(int)port
              filesToSend:(NSArray *)filesToSend
           transferSyntax:(int)transferSyntax
              compression: (float)compression
          extraParameters:(NSDictionary *)extraParameters __deprecated;

- (id) initWithCallingAET:(NSString *)myAET  
			calledAET:(NSString *)theirAET  
			hostname:(NSString *)hostname 
			port:(int)port 
			filesToSend:(NSArray *)filesToSend
			transferSyntax:(int)transferSyntax
			extraParameters:(NSDictionary *)extraParameters;
			
- (void)run;
- (void)run: (id) sender;
- (void)updateLogEntry: (NSMutableDictionary*) userInfo;
@end



