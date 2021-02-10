//
//  HorosServer.mm
//  pyOsiriXII
//
//  Created by Richard Holbrey on 30/11/2020.
//

#include "HorosServer.h"
#import <Foundation/Foundation.h>

namespace pyosirix {

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
    
    // set unlimited receive.... default is GRPC_DEFAULT_MAX_RECV_MESSAGE_LENGTH = 4MB
    builder.SetMaxReceiveMessageSize(-1);
    
    //borrowed from https://stackoverflow.com/questions/32792284/grpc-in-cpp-providing-tls-support
    std::shared_ptr<grpc::ServerCredentials> creds;
//    if( p_Adaptor->EnableSSL )
//    {
//        grpc::SslServerCredentialsOptions::PemKeyCertPair pkcp ={"a","b"};
//        grpc::SslServerCredentialsOptions ssl_opts;
//        ssl_opts.pem_root_certs="";
//        ssl_opts.pem_key_cert_pairs.push_back(pkcp);
//        creds = grpc::SslServerCredentials(ssl_opts);
//    }
//    else
        creds = grpc::InsecureServerCredentials();
    
    
    // Listen on the given address without any authentication mechanism.
    builder.AddListeningPort(server_address, creds);
    
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


Status HorosServer::GetCurrentImageData(ServerContext* context,
                                        const DicomDataRequest* request,
                                        DicomDataResponse* reply ) {
  
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
    
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentImageData:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}

Status HorosServer::GetCurrentVersion( ServerContext* context,
                                       const DicomDataRequest* request,
                                       DicomDataRequest* reply ) {
  
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
    
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentVersion:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}

Status HorosServer::GetCurrentImage(ServerContext* context,
                                    const ImageGetRequest* request,
                                    ImageGetResponse* reply ) {
    
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
    
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentImage:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}

Status HorosServer::
SetCurrentImage( ServerContext* context,
                 const ImageSetRequest* request,
                 ImageSetResponse* reply ) {
    
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
        
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(SetCurrentImage:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}

Status HorosServer::
GetSelectedROI( ServerContext* context,
                const ROIRequest* request,
                ROIResponse* reply )
{
    [p_Adaptor->Lock lock];
    p_Adaptor->Request = (const void*)request;
    p_Adaptor->Response = (void*)reply;
    [p_Adaptor->Lock unlock];
        
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
//    [(__bridge id)(p_Adaptor->Osirix)
//     performSelectorOnMainThread:@selector(SetCurrentImage:)
//     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    
    
    return Status::OK;
}

Status HorosServer::
GetSliceROIs( ServerContext* context,
              const ROIRequest* request,
              SliceROIResponse* reply )
{
    
    return Status::OK;
}

Status HorosServer::
GetStackROIs( ServerContext* context,
              const ROIRequest* request,
              StackROIResponse* reply )
{
    
    return Status::OK;
}



} //namespace pyosirix
