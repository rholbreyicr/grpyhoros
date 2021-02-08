// Generated by the gRPC C++ plugin.
// If you make any local change, they will be lost.
// source: horos.proto

#include "horos.pb.h"
#include "horos.grpc.pb.h"

#include <functional>
#include <grpcpp/impl/codegen/async_stream.h>
#include <grpcpp/impl/codegen/async_unary_call.h>
#include <grpcpp/impl/codegen/channel_interface.h>
#include <grpcpp/impl/codegen/client_unary_call.h>
#include <grpcpp/impl/codegen/client_callback.h>
#include <grpcpp/impl/codegen/message_allocator.h>
#include <grpcpp/impl/codegen/method_handler.h>
#include <grpcpp/impl/codegen/rpc_service_method.h>
#include <grpcpp/impl/codegen/server_callback.h>
#include <grpcpp/impl/codegen/server_callback_handlers.h>
#include <grpcpp/impl/codegen/server_context.h>
#include <grpcpp/impl/codegen/service_type.h>
#include <grpcpp/impl/codegen/sync_stream.h>
namespace pyosirix {

static const char* Horos_method_names[] = {
  "/icr.Horos/GetCurrentImageData",
  "/icr.Horos/GetCurrentImage",
  "/icr.Horos/SetCurrentImage",
  "/icr.Horos/GetROIList",
  "/icr.Horos/GetSelectedROI",
  "/icr.Horos/UpdateROI",
};

std::unique_ptr< Horos::Stub> Horos::NewStub(const std::shared_ptr< ::grpc::ChannelInterface>& channel, const ::grpc::StubOptions& options) {
  (void)options;
  std::unique_ptr< Horos::Stub> stub(new Horos::Stub(channel));
  return stub;
}

Horos::Stub::Stub(const std::shared_ptr< ::grpc::ChannelInterface>& channel)
  : channel_(channel), rpcmethod_GetCurrentImageData_(Horos_method_names[0], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  , rpcmethod_GetCurrentImage_(Horos_method_names[1], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  , rpcmethod_SetCurrentImage_(Horos_method_names[2], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  , rpcmethod_GetROIList_(Horos_method_names[3], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  , rpcmethod_GetSelectedROI_(Horos_method_names[4], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  , rpcmethod_UpdateROI_(Horos_method_names[5], ::grpc::internal::RpcMethod::NORMAL_RPC, channel)
  {}

::grpc::Status Horos::Stub::GetCurrentImageData(::grpc::ClientContext* context, const ::pyosirix::DicomDataRequest& request, ::pyosirix::DicomDataResponse* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::DicomDataRequest, ::pyosirix::DicomDataResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_GetCurrentImageData_, context, request, response);
}

void Horos::Stub::experimental_async::GetCurrentImageData(::grpc::ClientContext* context, const ::pyosirix::DicomDataRequest* request, ::pyosirix::DicomDataResponse* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::DicomDataRequest, ::pyosirix::DicomDataResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetCurrentImageData_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::GetCurrentImageData(::grpc::ClientContext* context, const ::pyosirix::DicomDataRequest* request, ::pyosirix::DicomDataResponse* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetCurrentImageData_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::DicomDataResponse>* Horos::Stub::PrepareAsyncGetCurrentImageDataRaw(::grpc::ClientContext* context, const ::pyosirix::DicomDataRequest& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::DicomDataResponse, ::pyosirix::DicomDataRequest, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_GetCurrentImageData_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::DicomDataResponse>* Horos::Stub::AsyncGetCurrentImageDataRaw(::grpc::ClientContext* context, const ::pyosirix::DicomDataRequest& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncGetCurrentImageDataRaw(context, request, cq);
  result->StartCall();
  return result;
}

::grpc::Status Horos::Stub::GetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageGetRequest& request, ::pyosirix::ImageGetResponse* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::ImageGetRequest, ::pyosirix::ImageGetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_GetCurrentImage_, context, request, response);
}

void Horos::Stub::experimental_async::GetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageGetRequest* request, ::pyosirix::ImageGetResponse* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::ImageGetRequest, ::pyosirix::ImageGetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetCurrentImage_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::GetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageGetRequest* request, ::pyosirix::ImageGetResponse* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetCurrentImage_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ImageGetResponse>* Horos::Stub::PrepareAsyncGetCurrentImageRaw(::grpc::ClientContext* context, const ::pyosirix::ImageGetRequest& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::ImageGetResponse, ::pyosirix::ImageGetRequest, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_GetCurrentImage_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ImageGetResponse>* Horos::Stub::AsyncGetCurrentImageRaw(::grpc::ClientContext* context, const ::pyosirix::ImageGetRequest& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncGetCurrentImageRaw(context, request, cq);
  result->StartCall();
  return result;
}

::grpc::Status Horos::Stub::SetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageSetRequest& request, ::pyosirix::ImageSetResponse* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::ImageSetRequest, ::pyosirix::ImageSetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_SetCurrentImage_, context, request, response);
}

void Horos::Stub::experimental_async::SetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageSetRequest* request, ::pyosirix::ImageSetResponse* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::ImageSetRequest, ::pyosirix::ImageSetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_SetCurrentImage_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::SetCurrentImage(::grpc::ClientContext* context, const ::pyosirix::ImageSetRequest* request, ::pyosirix::ImageSetResponse* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_SetCurrentImage_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ImageSetResponse>* Horos::Stub::PrepareAsyncSetCurrentImageRaw(::grpc::ClientContext* context, const ::pyosirix::ImageSetRequest& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::ImageSetResponse, ::pyosirix::ImageSetRequest, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_SetCurrentImage_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ImageSetResponse>* Horos::Stub::AsyncSetCurrentImageRaw(::grpc::ClientContext* context, const ::pyosirix::ImageSetRequest& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncSetCurrentImageRaw(context, request, cq);
  result->StartCall();
  return result;
}

::grpc::Status Horos::Stub::GetROIList(::grpc::ClientContext* context, const ::pyosirix::ROIListRequest& request, ::pyosirix::ROIList* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::ROIListRequest, ::pyosirix::ROIList, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_GetROIList_, context, request, response);
}

void Horos::Stub::experimental_async::GetROIList(::grpc::ClientContext* context, const ::pyosirix::ROIListRequest* request, ::pyosirix::ROIList* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::ROIListRequest, ::pyosirix::ROIList, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetROIList_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::GetROIList(::grpc::ClientContext* context, const ::pyosirix::ROIListRequest* request, ::pyosirix::ROIList* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetROIList_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ROIList>* Horos::Stub::PrepareAsyncGetROIListRaw(::grpc::ClientContext* context, const ::pyosirix::ROIListRequest& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::ROIList, ::pyosirix::ROIListRequest, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_GetROIList_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ROIList>* Horos::Stub::AsyncGetROIListRaw(::grpc::ClientContext* context, const ::pyosirix::ROIListRequest& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncGetROIListRaw(context, request, cq);
  result->StartCall();
  return result;
}

::grpc::Status Horos::Stub::GetSelectedROI(::grpc::ClientContext* context, const ::pyosirix::ROIRequest& request, ::pyosirix::ROI* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::ROIRequest, ::pyosirix::ROI, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_GetSelectedROI_, context, request, response);
}

void Horos::Stub::experimental_async::GetSelectedROI(::grpc::ClientContext* context, const ::pyosirix::ROIRequest* request, ::pyosirix::ROI* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::ROIRequest, ::pyosirix::ROI, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetSelectedROI_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::GetSelectedROI(::grpc::ClientContext* context, const ::pyosirix::ROIRequest* request, ::pyosirix::ROI* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_GetSelectedROI_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ROI>* Horos::Stub::PrepareAsyncGetSelectedROIRaw(::grpc::ClientContext* context, const ::pyosirix::ROIRequest& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::ROI, ::pyosirix::ROIRequest, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_GetSelectedROI_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::ROI>* Horos::Stub::AsyncGetSelectedROIRaw(::grpc::ClientContext* context, const ::pyosirix::ROIRequest& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncGetSelectedROIRaw(context, request, cq);
  result->StartCall();
  return result;
}

::grpc::Status Horos::Stub::UpdateROI(::grpc::ClientContext* context, const ::pyosirix::ROI& request, ::pyosirix::UpdateROIResponse* response) {
  return ::grpc::internal::BlockingUnaryCall< ::pyosirix::ROI, ::pyosirix::UpdateROIResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), rpcmethod_UpdateROI_, context, request, response);
}

void Horos::Stub::experimental_async::UpdateROI(::grpc::ClientContext* context, const ::pyosirix::ROI* request, ::pyosirix::UpdateROIResponse* response, std::function<void(::grpc::Status)> f) {
  ::grpc::internal::CallbackUnaryCall< ::pyosirix::ROI, ::pyosirix::UpdateROIResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_UpdateROI_, context, request, response, std::move(f));
}

void Horos::Stub::experimental_async::UpdateROI(::grpc::ClientContext* context, const ::pyosirix::ROI* request, ::pyosirix::UpdateROIResponse* response, ::grpc::experimental::ClientUnaryReactor* reactor) {
  ::grpc::internal::ClientCallbackUnaryFactory::Create< ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(stub_->channel_.get(), stub_->rpcmethod_UpdateROI_, context, request, response, reactor);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::UpdateROIResponse>* Horos::Stub::PrepareAsyncUpdateROIRaw(::grpc::ClientContext* context, const ::pyosirix::ROI& request, ::grpc::CompletionQueue* cq) {
  return ::grpc::internal::ClientAsyncResponseReaderHelper::Create< ::pyosirix::UpdateROIResponse, ::pyosirix::ROI, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(channel_.get(), cq, rpcmethod_UpdateROI_, context, request);
}

::grpc::ClientAsyncResponseReader< ::pyosirix::UpdateROIResponse>* Horos::Stub::AsyncUpdateROIRaw(::grpc::ClientContext* context, const ::pyosirix::ROI& request, ::grpc::CompletionQueue* cq) {
  auto* result =
    this->PrepareAsyncUpdateROIRaw(context, request, cq);
  result->StartCall();
  return result;
}

Horos::Service::Service() {
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[0],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::DicomDataRequest, ::pyosirix::DicomDataResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::DicomDataRequest* req,
             ::pyosirix::DicomDataResponse* resp) {
               return service->GetCurrentImageData(ctx, req, resp);
             }, this)));
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[1],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::ImageGetRequest, ::pyosirix::ImageGetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::ImageGetRequest* req,
             ::pyosirix::ImageGetResponse* resp) {
               return service->GetCurrentImage(ctx, req, resp);
             }, this)));
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[2],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::ImageSetRequest, ::pyosirix::ImageSetResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::ImageSetRequest* req,
             ::pyosirix::ImageSetResponse* resp) {
               return service->SetCurrentImage(ctx, req, resp);
             }, this)));
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[3],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::ROIListRequest, ::pyosirix::ROIList, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::ROIListRequest* req,
             ::pyosirix::ROIList* resp) {
               return service->GetROIList(ctx, req, resp);
             }, this)));
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[4],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::ROIRequest, ::pyosirix::ROI, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::ROIRequest* req,
             ::pyosirix::ROI* resp) {
               return service->GetSelectedROI(ctx, req, resp);
             }, this)));
  AddMethod(new ::grpc::internal::RpcServiceMethod(
      Horos_method_names[5],
      ::grpc::internal::RpcMethod::NORMAL_RPC,
      new ::grpc::internal::RpcMethodHandler< Horos::Service, ::pyosirix::ROI, ::pyosirix::UpdateROIResponse, ::grpc::protobuf::MessageLite, ::grpc::protobuf::MessageLite>(
          [](Horos::Service* service,
             ::grpc::ServerContext* ctx,
             const ::pyosirix::ROI* req,
             ::pyosirix::UpdateROIResponse* resp) {
               return service->UpdateROI(ctx, req, resp);
             }, this)));
}

Horos::Service::~Service() {
}

::grpc::Status Horos::Service::GetCurrentImageData(::grpc::ServerContext* context, const ::pyosirix::DicomDataRequest* request, ::pyosirix::DicomDataResponse* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}

::grpc::Status Horos::Service::GetCurrentImage(::grpc::ServerContext* context, const ::pyosirix::ImageGetRequest* request, ::pyosirix::ImageGetResponse* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}

::grpc::Status Horos::Service::SetCurrentImage(::grpc::ServerContext* context, const ::pyosirix::ImageSetRequest* request, ::pyosirix::ImageSetResponse* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}

::grpc::Status Horos::Service::GetROIList(::grpc::ServerContext* context, const ::pyosirix::ROIListRequest* request, ::pyosirix::ROIList* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}

::grpc::Status Horos::Service::GetSelectedROI(::grpc::ServerContext* context, const ::pyosirix::ROIRequest* request, ::pyosirix::ROI* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}

::grpc::Status Horos::Service::UpdateROI(::grpc::ServerContext* context, const ::pyosirix::ROI* request, ::pyosirix::UpdateROIResponse* response) {
  (void) context;
  (void) request;
  (void) response;
  return ::grpc::Status(::grpc::StatusCode::UNIMPLEMENTED, "");
}


}  // namespace icr

