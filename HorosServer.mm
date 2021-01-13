//
//  HorosServer.mm
//  pyOsiriXII
//
//  Created by Richard Holbrey on 30/11/2020.
//

#include "HorosServer.h"
#import <Foundation/Foundation.h>

namespace icr {

ServerAdaptor* HorosServer::p_Adaptor = NULL;

void* HorosServer::RunServer( void* input ) {
            
    std::string server_address( "0.0.0.0:50051" );
    if( input ) {
        // Copy pointer, declared in pyOsiriXIIFilter, but don't take ownership
        p_Adaptor = (ServerAdaptor*)input;
        server_address = std::string( "0.0.0.0:" );
        server_address.append( p_Adaptor->Port );
    }
    
    HorosServer service;
    grpc::EnableDefaultHealthCheckService(true);
    grpc::reflection::InitProtoReflectionServerBuilderPlugin();
    ServerBuilder builder;
    
    // Listen on the given address without any authentication mechanism.
    builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
    
    // Register "service" as the instance through which we'll communicate with
    // clients. In this case it corresponds to an *synchronous* service.
    builder.RegisterService(&service);
    
    // Finally assemble the server.
    std::unique_ptr<Server> server(builder.BuildAndStart());
    NSString* listening_str = [NSString stringWithFormat: @"Server listening on %@", [NSString stringWithUTF8String:server_address.c_str()] ];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(LogConnection:)
     withObject:listening_str  waitUntilDone:NO];
    
        
    // Wait for the server to shutdown. Note that some other thread must be
    // responsible for shutting down the server for this call to ever return.
    server->Wait();
    
    return NULL;
}


//@todo need to elaborate and protect with mutex
//std::string HorosServer::CurrentDicomImage;
    
Status HorosServer::GetCurrentImageFile(ServerContext* context,
                                        const DicomNameRequest* request,
                                        DicomNameResponse* reply ) {
  
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
    
    NSString* dummy_str = [[NSString stringWithFormat: @"log_string" ] retain];  // only needed for selector call... used id?
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentImageFile:)
     withObject:dummy_str waitUntilDone:YES];
    
    [dummy_str release];
    return Status::OK;
}
    
Status HorosServer::GetCurrentImage(ServerContext* context,
                                    const DicomImageRequest* request,
                                    DicomImageResponse* reply ) {
    
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
        
    NSString* dummy_str = [[NSString stringWithFormat: @"log_string" ] retain];  // only needed for selector call... used id?
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentImage:)
     withObject:dummy_str waitUntilDone:YES];
    
    [dummy_str release];    
    return Status::OK;
}

} //namespace icr
