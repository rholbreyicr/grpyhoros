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

#import "N2ManagedDatabase.h"

enum {Compress, Decompress};

extern NSString* const CurrentDatabaseVersion;
extern NSString* const OsirixDataDirName;
extern NSString* const O2ScreenCapturesSeriesName;

@class N2MutableUInteger, DicomAlbum, DataNodeIdentifier;

@interface DicomDatabase : N2ManagedDatabase {
	N2MutableUInteger* _dataFileIndex;
	NSString* _baseDirPath;
	NSString* _dataBaseDirPath;
    NSTimeInterval lastDatabaseDirPathCheck;
    NSString* _lastDataDirPathCheck;
    NSString* _sourcePath;
	NSString* _name;
	NSRecursiveLock* _processFilesLock;
	NSRecursiveLock* _importFilesFromIncomingDirLock;
	BOOL _isFileSystemFreeSizeLimitReached;
	NSTimeInterval _timeOfLastIsFileSystemFreeSizeLimitReachedVerification;
    NSTimeInterval _lastCleanForFreeSpaceTimeInterval;
	char baseDirPathC[4096], incomingDirPathC[4096], tempDirPathC[4096]; // these paths are used from the DICOM listener
    BOOL _isReadOnly, _hasPotentiallySlowDataAccess;
    // compression/decompression
    NSMutableArray* _decompressQueue;
    NSMutableArray* _compressQueue;
    NSThread* _compressDecompressThread;
    NSMutableArray *compressingSOPs;
	// +Routing
	NSMutableArray* _routingSendQueues;
	NSRecursiveLock* _routingLock;
	// +Clean
	NSRecursiveLock* _cleanLock;
    NSString* uniqueTmpfolder;
    
    BOOL protectionAgainstReentry;
    volatile BOOL _deallocating;
}

+(void)initializeDicomDatabaseClass;
+(void)recomputePatientUIDsInContext:(NSManagedObjectContext*)context;

+(NSString*)defaultBaseDirPath;
+(NSString*)baseDirPathForPath:(NSString*)path;
+(NSString*)baseDirPathForMode:(int)mode path:(NSString*)path;

+(NSArray*)allDatabases;
+(DicomDatabase*)defaultDatabase;
+(DicomDatabase*)databaseAtPath:(NSString*)path;
+(DicomDatabase*)databaseAtPath:(NSString*)path name:(NSString*)name;
+(DicomDatabase*)databaseAtPath:(NSString*)path name:(NSString*)name createIfNecessary:(BOOL)create;
+(DicomDatabase*)existingDatabaseAtPath:(NSString*)path;
+(DicomDatabase*)databaseForContext:(NSManagedObjectContext*)c; // hopefully one day this will be __deprecated
+(DicomDatabase*)activeLocalDatabase;
+(void)setActiveLocalDatabase:(DicomDatabase*)ldb;

@property(readonly,retain) NSString* baseDirPath, *uniqueTmpfolder; // OsiriX Data
@property(readonly,retain) NSString* dataBaseDirPath; // depends on the content of the file at baseDirPath/DBFOLDER_LOCATION
@property(readwrite,retain,nonatomic) NSString* name, *sourcePath;
@property(nonatomic) BOOL isReadOnly;
@property(readonly) NSMutableArray *compressingSOPs;
@property BOOL hasPotentiallySlowDataAccess;
@property (nonatomic) NSTimeInterval timeOfLastIsFileSystemFreeSizeLimitReachedVerification, lastCleanForFreeSpaceTimeInterval;
@property (nonatomic) BOOL isFileSystemFreeSizeLimitReached;

-(BOOL)isLocal;

-(DataNodeIdentifier*)dataNodeIdentifier;

#pragma mark Entities
extern NSString* const DicomDatabaseImageEntityName;
extern NSString* const DicomDatabaseSeriesEntityName;
extern NSString* const DicomDatabaseStudyEntityName;
extern NSString* const DicomDatabaseAlbumEntityName;
extern NSString* const DicomDatabaseLogEntryEntityName;
-(NSEntityDescription*)imageEntity;
-(NSEntityDescription*)seriesEntity;
-(NSEntityDescription*)studyEntity;
-(NSEntityDescription*)albumEntity;
-(NSEntityDescription*)logEntryEntity;

#pragma mark Paths
// these paths are inside baseDirPath
// -(NSString*)sqlFilePath; // this is already defined in N2ManagedDatabase
-(NSString*)modelVersionFilePath; // this should become private
-(NSString*)loadingFilePath; // this should become private
// these paths are inside dataBaseDirPath
-(NSString*)dataDirPath;
-(NSString*)incomingDirPath;
-(NSString*)errorsDirPath;
-(NSString*)decompressionDirPath;
-(NSString*)toBeIndexedDirPath;
-(NSString*)reportsDirPath;
-(NSString*)tempDirPath;
-(NSString*)dumpDirPath;
-(NSString*)pagesDirPath;
-(NSString*)htmlTemplatesDirPath;
// these paths are used from the DICOM listener
-(const char*)baseDirPathC;
-(const char*)incomingDirPathC;
-(const char*)tempDirPathC;

-(NSUInteger)computeDataFileIndex; // this method should be private, but is declared because called from deprecated api
-(NSString*)uniquePathForNewDataFileWithExtension:(NSString*)ext;
-(NSString*)uniquePathForNewDataFileWithExtension:(NSString*)ext forStore: (NSPersistentStore*) store;

#pragma mark Albums
-(void)addDefaultAlbums;
-(NSArray*)albums;
+(NSPredicate*)predicateForSmartAlbumFilter:(NSString*)string;
-(void) saveAlbumsToPath:(NSString*) path;
-(void) loadAlbumsFromPath:(NSString*) path;
-(void) addStudies:(NSArray*)dicomStudies toAlbum:(DicomAlbum*)dicomAlbum;
-(NSArray*) reindexObjects: (NSArray*) objects;

#pragma mark Add files
-(NSArray*)addFilesAtPaths:(NSArray*)paths;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly rereadExistingItems:(BOOL)rereadExistingItems;	
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX returnArray: (BOOL) returnArray;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX importedFiles: (BOOL) importedFiles returnArray: (BOOL) returnArray;

-(NSArray*)addFilesDescribedInDictionaries:(NSArray*)dicomFilesArray postNotifications:(BOOL)postNotifications rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX; // returns NSArray<NSManagedObjectID>
-(NSArray*)addFilesDescribedInDictionaries:(NSArray*)dicomFilesArray postNotifications:(BOOL)postNotifications rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX returnArray: (BOOL) returnArray;
-(NSArray*)addFilesDescribedInDictionaries:(NSArray*)dicomFilesArray postNotifications:(BOOL)postNotifications rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX importedFiles: (BOOL) importedFiles returnArray: (BOOL) returnArray;
-(NSArray*)addFilesAtPaths:(NSArray*)paths postNotifications:(BOOL)postNotifications dicomOnly:(BOOL)dicomOnly rereadExistingItems:(BOOL)rereadExistingItems generatedByOsiriX:(BOOL)generatedByOsiriX importedFiles: (BOOL) importedFiles returnArray: (BOOL) returnArray dicomFileDictionary: (NSArray*) dicomFilesArray;
#pragma mark Incoming
-(BOOL)checkIfFileSystemFreeSizeLimitReached;
-(BOOL) hasFilesToImport;
-(NSInteger)importFilesFromIncomingDir;
-(NSInteger)importFilesFromIncomingDir: (NSNumber*) showGUI;
-(NSInteger)importFilesFromIncomingDir: (NSNumber*) showGUI listenerCompressionSettings: (int) listenerCompressionSettings;
-(BOOL)waitForCompressThread;
-(void)initiateImportFilesFromIncomingDirUnlessAlreadyImporting;
-(void)importFilesFromIncomingDirThread;
+(void)syncImportFilesFromIncomingDirTimerWithUserDefaults; // called from deprecated API

#pragma mark Compress/decompress
-(BOOL)compressFilesAtPaths:(NSArray*)paths;
-(BOOL)compressFilesAtPaths:(NSArray*)paths intoDirAtPath:(NSString*)destDir;
-(BOOL)decompressFilesAtPaths:(NSArray*)paths;
-(BOOL)decompressFilesAtPaths:(NSArray*)paths intoDirAtPath:(NSString*)destDir;
-(void)initiateCompressFilesAtPaths:(NSArray*)paths;
-(void)initiateCompressFilesAtPaths:(NSArray*)paths intoDirAtPath:(NSString*)destDir;
-(void)initiateDecompressFilesAtPaths:(NSArray*)paths;
-(void)initiateDecompressFilesAtPaths:(NSArray*)paths intoDirAtPath:(NSString*)destDir;
-(void)processFilesAtPaths:(NSArray*)paths intoDirAtPath:(NSString*)destDir mode:(int)mode;

#pragma mark Other
-(BOOL)rebuildAllowed;
// some of these methods should be private, but is declared because called from deprecated api
-(void)rebuild;
-(void)rebuild:(BOOL)complete;
-(void)checkForExistingReportForStudy:(NSManagedObject*)study;
-(void)checkReportsConsistencyWithDICOMSR;
-(void)rebuildSqlFile;
-(void)checkForHtmlTemplates;

- (NSSet*) deleteObjectIDs: (NSArray*) objectsToDelete;

// methods to overload when one needs to ask for confirmation about autorouting
-(BOOL)allowAutoroutingWithPostNotifications:(BOOL)postNotifications rereadExistingItems:(BOOL)rereadExistingItems;
-(void)alertToApplyRoutingRules:(NSArray*)routingRules toImages:(NSArray*)images;

@end

#import "DicomDatabase+Routing.h"
#import "DicomDatabase+Clean.h"

