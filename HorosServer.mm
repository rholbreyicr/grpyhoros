//
//  HorosServer.mm
//  pyOsiriXII
//
//  Created by Richard Holbrey on 30/11/2020.
//

#include "HorosServer.h"
#import <Foundation/Foundation.h>

static const char* ServerMethods[] = {
  "GetMethods: return a list of methods available from the server",
  "GetCurrentImageData: retrieve information about the current 2DViewer image",
  "GetCurrentVersion: get the current version of Horos/OsiriX (and reset if necessary)",
  "GetCurrentImage: retrieve the current 2DViewer image",
  "SetCurrentImage: set the current 2DViewer image",
  "SetROIOpacity: set the opacity property of current ROIs",
  "SetROIMoveAll: move all the ROIs in the current 2DViewer by the offset parameter (origin lower left)",
  "SetROIMoveSelected: move the selected ROIs in the current 2DViewer by the offset parameter (origin lower left)",
  "GetROIsAsList: dump the current ROI series as csv/xml to /tmp",
  "GetROIsAsImage: write the current ROI series to 3d image and get the (mhd) filename"
};

namespace pyosirix {

ServerAdaptor* HorosServer::p_Adaptor = NULL;

void* HorosServer::RunServer( void* input ) {
            
    std::string server_address( "localhost:50051" );
    if( input ) {
        // Copy pointer, declared in pyOsiriXIIFilter, but don't take ownership
        p_Adaptor = (ServerAdaptor*)input;
        server_address = std::string( "localhost:" );
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


Status HorosServer::
GetMethods( ServerContext* context,
            const DicomDataRequest* request,
            MethodResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;

        for( size_t k=0; k<sizeof(ServerMethods)/sizeof(const char*); k++ )
            reply->add_method_list( ServerMethods[k] );
        
        [p_Adaptor->Lock unlock];
    }
    else
        return Status::CANCELLED;
    
    return Status::OK;
}


Status HorosServer::
GetCurrentImageData( ServerContext* context,
                     const DicomDataRequest* request,
                     DicomDataResponse* reply ) {
  
    NSString* arg_str;
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        
        arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
        [p_Adaptor->Lock unlock];
    }
    else
        return Status::CANCELLED;
        
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentImageData:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}

Status HorosServer::
GetCurrentVersion( ServerContext* context,
                   const DicomDataRequest* request,
                   DicomDataRequest* reply ) {
  
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
    }
    else
    {
        //try this in desperation
        [p_Adaptor->Lock unlock];
        
        //... and repeat
        if( [p_Adaptor->Lock tryLock] )
        {
            p_Adaptor->Request = (const void*)request;
            p_Adaptor->Response = (void*)reply;
            [p_Adaptor->Lock unlock];
        }
        else
            return Status::CANCELLED;
    }
    
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetCurrentVersion:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}


Status HorosServer::
GetCurrentImage( ServerContext* context,
                 const ImageGetRequest* request,
                 ImageGetResponse* reply ) {
    
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
    }
    else
        return Status::CANCELLED;
        
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
    
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
    }
    else
        return Status::CANCELLED;
        
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(SetCurrentImage:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    return Status::OK;
}


Status HorosServer::
GetROIsAsList( ServerContext* context,
               const ROIListRequest* request,
               ROIListResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
    }
    else
        return Status::CANCELLED;
        
    NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
    [(__bridge id)(p_Adaptor->Osirix)
     performSelectorOnMainThread:@selector(GetROIsAsList:)
     withObject:arg_str waitUntilDone:YES];
    
    [arg_str release];
    
    return Status::OK;
}

Status HorosServer::
GetROIsAsImage( ServerContext* context,
                const ROIImageRequest* request,
                ROIImageResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
            
        NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
        [(__bridge id)(p_Adaptor->Osirix)
         performSelectorOnMainThread:@selector(GetROIsAsImage:)
         withObject:arg_str waitUntilDone:YES];
        
        [arg_str release];
    }
    else
        return Status::CANCELLED;
    
    return Status::OK;
}

Status HorosServer::
SetROIOpacity( ServerContext* context,
                const ROI* request,
                NullResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
            
        NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
        [(__bridge id)(p_Adaptor->Osirix)
         performSelectorOnMainThread:@selector(SetROIOpacity:)
         withObject:arg_str waitUntilDone:YES];
        
        [arg_str release];
    }
    else
        return Status::CANCELLED;
    
    return Status::OK;
}

Status HorosServer::
SetROIMoveAll( ServerContext* context,
               const ROI* request,
               NullResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
            
        NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
        [(__bridge id)(p_Adaptor->Osirix)
         performSelectorOnMainThread:@selector(SetROIMoveAll:)
         withObject:arg_str waitUntilDone:YES];
        
        [arg_str release];
    }
    else
        return Status::CANCELLED;
    
    return Status::OK;
}

Status HorosServer::
SetROIMoveSelected( ServerContext* context,
                    const ROI* request,
                    NullResponse* reply )
{
    if( [p_Adaptor->Lock tryLock] )
    {
        p_Adaptor->Request = (const void*)request;
        p_Adaptor->Response = (void*)reply;
        [p_Adaptor->Lock unlock];
            
        NSString* arg_str = [[NSString stringWithUTF8String:(request->id().c_str())] retain];
        [(__bridge id)(p_Adaptor->Osirix)
         performSelectorOnMainThread:@selector(SetROIMoveSelected:)
         withObject:arg_str waitUntilDone:YES];
        
        [arg_str release];
    }
    else
        return Status::CANCELLED;
    
    return Status::OK;
}



} //namespace pyosirix
