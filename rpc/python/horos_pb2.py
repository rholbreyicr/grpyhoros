# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: horos.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


import roi_pb2 as roi__pb2


DESCRIPTOR = _descriptor.FileDescriptor(
  name='horos.proto',
  package='pyosirix',
  syntax='proto3',
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x0bhoros.proto\x12\x08pyosirix\x1a\troi.proto\"\x1e\n\x10\x44icomDataRequest\x12\n\n\x02id\x18\x01 \x01(\t\"\x1a\n\x0cNullResponse\x12\n\n\x02id\x18\x01 \x01(\t\"\x7f\n\x11\x44icomDataResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x12\n\npatient_id\x18\x02 \x01(\t\x12\x1a\n\x12study_instance_uid\x18\x03 \x01(\t\x12\x1b\n\x13series_instance_uid\x18\x04 \x01(\t\x12\x11\n\tfile_list\x18\x05 \x03(\t\"0\n\x0fImageGetRequest\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\"w\n\x10ImageGetResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\x12\x12\n\nimage_size\x18\x03 \x03(\x05\x12\x12\n\nvoxel_size\x18\x04 \x03(\x02\x12\x0e\n\x06origin\x18\x05 \x03(\x02\x12\x0c\n\x04\x64\x61ta\x18\x06 \x03(\x02\"v\n\x0fImageSetRequest\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\x12\x12\n\nimage_size\x18\x03 \x03(\x05\x12\x12\n\nvoxel_size\x18\x04 \x03(\x02\x12\x0e\n\x06origin\x18\x05 \x03(\x02\x12\x0c\n\x04\x64\x61ta\x18\x06 \x03(\x02\"1\n\x10ImageSetResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\"1\n\x0eMethodResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x13\n\x0bmethod_list\x18\x02 \x03(\t2\xcc\x05\n\x05Horos\x12M\n\x11GetCurrentVersion\x12\x1a.pyosirix.DicomDataRequest\x1a\x1a.pyosirix.DicomDataRequest\"\x00\x12P\n\x13GetCurrentImageData\x12\x1a.pyosirix.DicomDataRequest\x1a\x1b.pyosirix.DicomDataResponse\"\x00\x12J\n\x0fGetCurrentImage\x12\x19.pyosirix.ImageGetRequest\x1a\x1a.pyosirix.ImageGetResponse\"\x00\x12J\n\x0fSetCurrentImage\x12\x19.pyosirix.ImageSetRequest\x1a\x1a.pyosirix.ImageSetResponse\"\x00\x12\x46\n\rGetROIsAsList\x12\x18.pyosirix.ROIListRequest\x1a\x19.pyosirix.ROIListResponse\"\x00\x12I\n\x0eGetROIsAsImage\x12\x19.pyosirix.ROIImageRequest\x1a\x1a.pyosirix.ROIImageResponse\"\x00\x12\x38\n\rSetROIOpacity\x12\r.pyosirix.ROI\x1a\x16.pyosirix.NullResponse\"\x00\x12\x38\n\rSetROIMoveAll\x12\r.pyosirix.ROI\x1a\x16.pyosirix.NullResponse\"\x00\x12=\n\x12SetROIMoveSelected\x12\r.pyosirix.ROI\x1a\x16.pyosirix.NullResponse\"\x00\x12\x44\n\nGetMethods\x12\x1a.pyosirix.DicomDataRequest\x1a\x18.pyosirix.MethodResponse\"\x00\x62\x06proto3'
  ,
  dependencies=[roi__pb2.DESCRIPTOR,])




_DICOMDATAREQUEST = _descriptor.Descriptor(
  name='DicomDataRequest',
  full_name='pyosirix.DicomDataRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.DicomDataRequest.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=36,
  serialized_end=66,
)


_NULLRESPONSE = _descriptor.Descriptor(
  name='NullResponse',
  full_name='pyosirix.NullResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.NullResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=68,
  serialized_end=94,
)


_DICOMDATARESPONSE = _descriptor.Descriptor(
  name='DicomDataResponse',
  full_name='pyosirix.DicomDataResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.DicomDataResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='patient_id', full_name='pyosirix.DicomDataResponse.patient_id', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='study_instance_uid', full_name='pyosirix.DicomDataResponse.study_instance_uid', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='series_instance_uid', full_name='pyosirix.DicomDataResponse.series_instance_uid', index=3,
      number=4, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='file_list', full_name='pyosirix.DicomDataResponse.file_list', index=4,
      number=5, type=9, cpp_type=9, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=96,
  serialized_end=223,
)


_IMAGEGETREQUEST = _descriptor.Descriptor(
  name='ImageGetRequest',
  full_name='pyosirix.ImageGetRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.ImageGetRequest.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='pyosirix.ImageGetRequest.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=225,
  serialized_end=273,
)


_IMAGEGETRESPONSE = _descriptor.Descriptor(
  name='ImageGetResponse',
  full_name='pyosirix.ImageGetResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.ImageGetResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='pyosirix.ImageGetResponse.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='image_size', full_name='pyosirix.ImageGetResponse.image_size', index=2,
      number=3, type=5, cpp_type=1, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='voxel_size', full_name='pyosirix.ImageGetResponse.voxel_size', index=3,
      number=4, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='origin', full_name='pyosirix.ImageGetResponse.origin', index=4,
      number=5, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='data', full_name='pyosirix.ImageGetResponse.data', index=5,
      number=6, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=275,
  serialized_end=394,
)


_IMAGESETREQUEST = _descriptor.Descriptor(
  name='ImageSetRequest',
  full_name='pyosirix.ImageSetRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.ImageSetRequest.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='pyosirix.ImageSetRequest.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='image_size', full_name='pyosirix.ImageSetRequest.image_size', index=2,
      number=3, type=5, cpp_type=1, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='voxel_size', full_name='pyosirix.ImageSetRequest.voxel_size', index=3,
      number=4, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='origin', full_name='pyosirix.ImageSetRequest.origin', index=4,
      number=5, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='data', full_name='pyosirix.ImageSetRequest.data', index=5,
      number=6, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=396,
  serialized_end=514,
)


_IMAGESETRESPONSE = _descriptor.Descriptor(
  name='ImageSetResponse',
  full_name='pyosirix.ImageSetResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.ImageSetResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='pyosirix.ImageSetResponse.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=516,
  serialized_end=565,
)


_METHODRESPONSE = _descriptor.Descriptor(
  name='MethodResponse',
  full_name='pyosirix.MethodResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='pyosirix.MethodResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='method_list', full_name='pyosirix.MethodResponse.method_list', index=1,
      number=2, type=9, cpp_type=9, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  serialized_options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=567,
  serialized_end=616,
)

DESCRIPTOR.message_types_by_name['DicomDataRequest'] = _DICOMDATAREQUEST
DESCRIPTOR.message_types_by_name['NullResponse'] = _NULLRESPONSE
DESCRIPTOR.message_types_by_name['DicomDataResponse'] = _DICOMDATARESPONSE
DESCRIPTOR.message_types_by_name['ImageGetRequest'] = _IMAGEGETREQUEST
DESCRIPTOR.message_types_by_name['ImageGetResponse'] = _IMAGEGETRESPONSE
DESCRIPTOR.message_types_by_name['ImageSetRequest'] = _IMAGESETREQUEST
DESCRIPTOR.message_types_by_name['ImageSetResponse'] = _IMAGESETRESPONSE
DESCRIPTOR.message_types_by_name['MethodResponse'] = _METHODRESPONSE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

DicomDataRequest = _reflection.GeneratedProtocolMessageType('DicomDataRequest', (_message.Message,), {
  'DESCRIPTOR' : _DICOMDATAREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.DicomDataRequest)
  })
_sym_db.RegisterMessage(DicomDataRequest)

NullResponse = _reflection.GeneratedProtocolMessageType('NullResponse', (_message.Message,), {
  'DESCRIPTOR' : _NULLRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.NullResponse)
  })
_sym_db.RegisterMessage(NullResponse)

DicomDataResponse = _reflection.GeneratedProtocolMessageType('DicomDataResponse', (_message.Message,), {
  'DESCRIPTOR' : _DICOMDATARESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.DicomDataResponse)
  })
_sym_db.RegisterMessage(DicomDataResponse)

ImageGetRequest = _reflection.GeneratedProtocolMessageType('ImageGetRequest', (_message.Message,), {
  'DESCRIPTOR' : _IMAGEGETREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.ImageGetRequest)
  })
_sym_db.RegisterMessage(ImageGetRequest)

ImageGetResponse = _reflection.GeneratedProtocolMessageType('ImageGetResponse', (_message.Message,), {
  'DESCRIPTOR' : _IMAGEGETRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.ImageGetResponse)
  })
_sym_db.RegisterMessage(ImageGetResponse)

ImageSetRequest = _reflection.GeneratedProtocolMessageType('ImageSetRequest', (_message.Message,), {
  'DESCRIPTOR' : _IMAGESETREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.ImageSetRequest)
  })
_sym_db.RegisterMessage(ImageSetRequest)

ImageSetResponse = _reflection.GeneratedProtocolMessageType('ImageSetResponse', (_message.Message,), {
  'DESCRIPTOR' : _IMAGESETRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.ImageSetResponse)
  })
_sym_db.RegisterMessage(ImageSetResponse)

MethodResponse = _reflection.GeneratedProtocolMessageType('MethodResponse', (_message.Message,), {
  'DESCRIPTOR' : _METHODRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:pyosirix.MethodResponse)
  })
_sym_db.RegisterMessage(MethodResponse)



_HOROS = _descriptor.ServiceDescriptor(
  name='Horos',
  full_name='pyosirix.Horos',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=619,
  serialized_end=1335,
  methods=[
  _descriptor.MethodDescriptor(
    name='GetCurrentVersion',
    full_name='pyosirix.Horos.GetCurrentVersion',
    index=0,
    containing_service=None,
    input_type=_DICOMDATAREQUEST,
    output_type=_DICOMDATAREQUEST,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetCurrentImageData',
    full_name='pyosirix.Horos.GetCurrentImageData',
    index=1,
    containing_service=None,
    input_type=_DICOMDATAREQUEST,
    output_type=_DICOMDATARESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetCurrentImage',
    full_name='pyosirix.Horos.GetCurrentImage',
    index=2,
    containing_service=None,
    input_type=_IMAGEGETREQUEST,
    output_type=_IMAGEGETRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SetCurrentImage',
    full_name='pyosirix.Horos.SetCurrentImage',
    index=3,
    containing_service=None,
    input_type=_IMAGESETREQUEST,
    output_type=_IMAGESETRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetROIsAsList',
    full_name='pyosirix.Horos.GetROIsAsList',
    index=4,
    containing_service=None,
    input_type=roi__pb2._ROILISTREQUEST,
    output_type=roi__pb2._ROILISTRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetROIsAsImage',
    full_name='pyosirix.Horos.GetROIsAsImage',
    index=5,
    containing_service=None,
    input_type=roi__pb2._ROIIMAGEREQUEST,
    output_type=roi__pb2._ROIIMAGERESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SetROIOpacity',
    full_name='pyosirix.Horos.SetROIOpacity',
    index=6,
    containing_service=None,
    input_type=roi__pb2._ROI,
    output_type=_NULLRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SetROIMoveAll',
    full_name='pyosirix.Horos.SetROIMoveAll',
    index=7,
    containing_service=None,
    input_type=roi__pb2._ROI,
    output_type=_NULLRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SetROIMoveSelected',
    full_name='pyosirix.Horos.SetROIMoveSelected',
    index=8,
    containing_service=None,
    input_type=roi__pb2._ROI,
    output_type=_NULLRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetMethods',
    full_name='pyosirix.Horos.GetMethods',
    index=9,
    containing_service=None,
    input_type=_DICOMDATAREQUEST,
    output_type=_METHODRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_HOROS)

DESCRIPTOR.services_by_name['Horos'] = _HOROS

# @@protoc_insertion_point(module_scope)
