//
//  HorosServer.hpp
//  pyOsiriXII
//
//  Created by Richard Holbrey on 30/11/2020.
//

#ifndef HorosServer_hpp
#define HorosServer_hpp

#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>
#include <grpcpp/health_check_service_interface.h>
#include <grpcpp/ext/proto_server_reflection_plugin.h>

#ifdef BAZEL_BUILD
#include "examples/protos/horos.grpc.pb.h"
#else
#include "horos.grpc.pb.h"
#endif

#include "ServerAdaptor.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;

namespace pyosirix {

/**
 @brief HorosServer Subclases from gRPC's proto defined server object. Each
 Status returning call is a client callable function defined in the 'proto' definition.
 
 The other main function of this class is start the server running on a detached thread.
 Unix pthreads are used for this: i) they're more basic (and cross-platform, which is how
 I know about them) and ii) using NSThread seems to disrupt the mechanism that Horos
 uses for its own threading and usually crashes immediately. The reason for this is not
 known, but presumably it's quite complex, and is not entirely surprising.
 
 (The plugin is not usable on OsiriX Lite at this time (though it does load), but presumably
 the same threading issue would apply.)
 */
class HorosServer final : public Horos::Service {

    /**
     @brief GetCurrentImageData
       (proto defined rpc call) Get the source file name of the current image of the 2D viewer
     @param context
     @param request
     @param reply
     */
    Status GetCurrentImageData( ServerContext* context,
                                const DicomDataRequest* request,
                                DicomDataResponse* reply ) override;

    /** Get the current version of the plugin/host software */
    Status GetCurrentVersion( ServerContext* context,
                              const DicomDataRequest* request,
                              DicomDataRequest* reply ) override;
    
    /**
     
     */
    Status GetCurrentImage(ServerContext* context,
                           const ImageGetRequest* request,
                           ImageGetResponse* reply ) override;
    
    Status SetCurrentImage(ServerContext* context,
                           const ImageSetRequest* request,
                           ImageSetResponse* reply ) override;

 
//    Status GetSelectedROI( ServerContext* context,
//                           const ROIRequest* request,
//                           ROIResponse* reply ) override;

//    Status GetSliceROIs( ServerContext* context,
//                         const ROIRequest* request,
//                         SliceROIResponse* reply ) override;
//
//    Status GetStackROIs( ServerContext* context,
//                         const ROIRequest* request,
//                         StackROIResponse* reply ) override;

    Status GetROIsAsList( ServerContext* context,
                          const ROIListRequest* request,
                          ROIListResponse* reply ) override;
    
    static ServerAdaptor* p_Adaptor;  ///< Pointer to adaptor, not owned by this class

public:

    /**
     @brief pthread callable routine
     @param input const char* port (if null, "50051")
     @return NULL
     */
    static void* RunServer( void* input ); // pthread call
};

}

#endif /* HorosServer_hpp */
