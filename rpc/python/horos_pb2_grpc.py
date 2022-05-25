# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import horos_pb2 as horos__pb2
import roi_pb2 as roi__pb2


class HorosStub(object):
    """A simple key-value storage service
    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.GetCurrentVersion = channel.unary_unary(
                '/pyosirix.Horos/GetCurrentVersion',
                request_serializer=horos__pb2.DicomDataRequest.SerializeToString,
                response_deserializer=horos__pb2.DicomDataRequest.FromString,
                )
        self.GetCurrentImageData = channel.unary_unary(
                '/pyosirix.Horos/GetCurrentImageData',
                request_serializer=horos__pb2.DicomDataRequest.SerializeToString,
                response_deserializer=horos__pb2.DicomDataResponse.FromString,
                )
        self.GetCurrentImage = channel.unary_unary(
                '/pyosirix.Horos/GetCurrentImage',
                request_serializer=horos__pb2.ImageGetRequest.SerializeToString,
                response_deserializer=horos__pb2.ImageGetResponse.FromString,
                )
        self.SetCurrentImage = channel.unary_unary(
                '/pyosirix.Horos/SetCurrentImage',
                request_serializer=horos__pb2.ImageSetRequest.SerializeToString,
                response_deserializer=horos__pb2.ImageSetResponse.FromString,
                )
        self.GetROIsAsList = channel.unary_unary(
                '/pyosirix.Horos/GetROIsAsList',
                request_serializer=roi__pb2.ROIListRequest.SerializeToString,
                response_deserializer=roi__pb2.ROIListResponse.FromString,
                )
        self.GetROIsAsImage = channel.unary_unary(
                '/pyosirix.Horos/GetROIsAsImage',
                request_serializer=roi__pb2.ROIImageRequest.SerializeToString,
                response_deserializer=roi__pb2.ROIImageResponse.FromString,
                )


class HorosServicer(object):
    """A simple key-value storage service
    """

    def GetCurrentVersion(self, request, context):
        """Request current plugin/host version
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetCurrentImageData(self, request, context):
        """Request current dicom image metadata
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetCurrentImage(self, request, context):
        """Request current dicom image metadata
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def SetCurrentImage(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetROIsAsList(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetROIsAsImage(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_HorosServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'GetCurrentVersion': grpc.unary_unary_rpc_method_handler(
                    servicer.GetCurrentVersion,
                    request_deserializer=horos__pb2.DicomDataRequest.FromString,
                    response_serializer=horos__pb2.DicomDataRequest.SerializeToString,
            ),
            'GetCurrentImageData': grpc.unary_unary_rpc_method_handler(
                    servicer.GetCurrentImageData,
                    request_deserializer=horos__pb2.DicomDataRequest.FromString,
                    response_serializer=horos__pb2.DicomDataResponse.SerializeToString,
            ),
            'GetCurrentImage': grpc.unary_unary_rpc_method_handler(
                    servicer.GetCurrentImage,
                    request_deserializer=horos__pb2.ImageGetRequest.FromString,
                    response_serializer=horos__pb2.ImageGetResponse.SerializeToString,
            ),
            'SetCurrentImage': grpc.unary_unary_rpc_method_handler(
                    servicer.SetCurrentImage,
                    request_deserializer=horos__pb2.ImageSetRequest.FromString,
                    response_serializer=horos__pb2.ImageSetResponse.SerializeToString,
            ),
            'GetROIsAsList': grpc.unary_unary_rpc_method_handler(
                    servicer.GetROIsAsList,
                    request_deserializer=roi__pb2.ROIListRequest.FromString,
                    response_serializer=roi__pb2.ROIListResponse.SerializeToString,
            ),
            'GetROIsAsImage': grpc.unary_unary_rpc_method_handler(
                    servicer.GetROIsAsImage,
                    request_deserializer=roi__pb2.ROIImageRequest.FromString,
                    response_serializer=roi__pb2.ROIImageResponse.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'pyosirix.Horos', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Horos(object):
    """A simple key-value storage service
    """

    @staticmethod
    def GetCurrentVersion(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/GetCurrentVersion',
            horos__pb2.DicomDataRequest.SerializeToString,
            horos__pb2.DicomDataRequest.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetCurrentImageData(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/GetCurrentImageData',
            horos__pb2.DicomDataRequest.SerializeToString,
            horos__pb2.DicomDataResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetCurrentImage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/GetCurrentImage',
            horos__pb2.ImageGetRequest.SerializeToString,
            horos__pb2.ImageGetResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def SetCurrentImage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/SetCurrentImage',
            horos__pb2.ImageSetRequest.SerializeToString,
            horos__pb2.ImageSetResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetROIsAsList(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/GetROIsAsList',
            roi__pb2.ROIListRequest.SerializeToString,
            roi__pb2.ROIListResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetROIsAsImage(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/pyosirix.Horos/GetROIsAsImage',
            roi__pb2.ROIImageRequest.SerializeToString,
            roi__pb2.ROIImageResponse.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
