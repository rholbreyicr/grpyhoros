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
  package='icr',
  syntax='proto3',
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x0bhoros.proto\x12\x03icr\x1a\troi.proto\"\x1e\n\x10\x44icomDataRequest\x12\n\n\x02id\x18\x01 \x01(\t\"\x7f\n\x11\x44icomDataResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x12\n\npatient_id\x18\x02 \x01(\t\x12\x1a\n\x12study_instance_uid\x18\x03 \x01(\t\x12\x1b\n\x13series_instance_uid\x18\x04 \x01(\t\x12\x11\n\tfile_list\x18\x05 \x03(\t\"0\n\x0fImageGetRequest\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\"w\n\x10ImageGetResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\x12\x12\n\nimage_size\x18\x03 \x03(\x05\x12\x12\n\nvoxel_size\x18\x04 \x03(\x02\x12\x0e\n\x06origin\x18\x05 \x03(\x02\x12\x0c\n\x04\x64\x61ta\x18\x06 \x03(\x02\"v\n\x0fImageSetRequest\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\x12\x12\n\nimage_size\x18\x03 \x03(\x05\x12\x12\n\nvoxel_size\x18\x04 \x03(\x02\x12\x0e\n\x06origin\x18\x05 \x03(\x02\x12\x0c\n\x04\x64\x61ta\x18\x06 \x03(\x02\"1\n\x10ImageSetResponse\x12\n\n\x02id\x18\x01 \x01(\t\x12\x11\n\tviewer_id\x18\x02 \x01(\x04\x32\xe6\x02\n\x05Horos\x12\x46\n\x13GetCurrentImageData\x12\x15.icr.DicomDataRequest\x1a\x16.icr.DicomDataResponse\"\x00\x12@\n\x0fGetCurrentImage\x12\x14.icr.ImageGetRequest\x1a\x15.icr.ImageGetResponse\"\x00\x12@\n\x0fSetCurrentImage\x12\x14.icr.ImageSetRequest\x1a\x15.icr.ImageSetResponse\"\x00\x12\x31\n\nGetROIList\x12\x13.icr.ROIListRequest\x1a\x0c.icr.ROIList\"\x00\x12-\n\x0eGetSelectedROI\x12\x0f.icr.ROIRequest\x1a\x08.icr.ROI\"\x00\x12/\n\tUpdateROI\x12\x08.icr.ROI\x1a\x16.icr.UpdateROIResponse\"\x00\x62\x06proto3'
  ,
  dependencies=[roi__pb2.DESCRIPTOR,])




_DICOMDATAREQUEST = _descriptor.Descriptor(
  name='DicomDataRequest',
  full_name='icr.DicomDataRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.DicomDataRequest.id', index=0,
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
  serialized_start=31,
  serialized_end=61,
)


_DICOMDATARESPONSE = _descriptor.Descriptor(
  name='DicomDataResponse',
  full_name='icr.DicomDataResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.DicomDataResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='patient_id', full_name='icr.DicomDataResponse.patient_id', index=1,
      number=2, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='study_instance_uid', full_name='icr.DicomDataResponse.study_instance_uid', index=2,
      number=3, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='series_instance_uid', full_name='icr.DicomDataResponse.series_instance_uid', index=3,
      number=4, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='file_list', full_name='icr.DicomDataResponse.file_list', index=4,
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
  serialized_start=63,
  serialized_end=190,
)


_IMAGEGETREQUEST = _descriptor.Descriptor(
  name='ImageGetRequest',
  full_name='icr.ImageGetRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.ImageGetRequest.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='icr.ImageGetRequest.viewer_id', index=1,
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
  serialized_start=192,
  serialized_end=240,
)


_IMAGEGETRESPONSE = _descriptor.Descriptor(
  name='ImageGetResponse',
  full_name='icr.ImageGetResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.ImageGetResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='icr.ImageGetResponse.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='image_size', full_name='icr.ImageGetResponse.image_size', index=2,
      number=3, type=5, cpp_type=1, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='voxel_size', full_name='icr.ImageGetResponse.voxel_size', index=3,
      number=4, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='origin', full_name='icr.ImageGetResponse.origin', index=4,
      number=5, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='data', full_name='icr.ImageGetResponse.data', index=5,
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
  serialized_start=242,
  serialized_end=361,
)


_IMAGESETREQUEST = _descriptor.Descriptor(
  name='ImageSetRequest',
  full_name='icr.ImageSetRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.ImageSetRequest.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='icr.ImageSetRequest.viewer_id', index=1,
      number=2, type=4, cpp_type=4, label=1,
      has_default_value=False, default_value=0,
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='image_size', full_name='icr.ImageSetRequest.image_size', index=2,
      number=3, type=5, cpp_type=1, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='voxel_size', full_name='icr.ImageSetRequest.voxel_size', index=3,
      number=4, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='origin', full_name='icr.ImageSetRequest.origin', index=4,
      number=5, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='data', full_name='icr.ImageSetRequest.data', index=5,
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
  serialized_start=363,
  serialized_end=481,
)


_IMAGESETRESPONSE = _descriptor.Descriptor(
  name='ImageSetResponse',
  full_name='icr.ImageSetResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.ImageSetResponse.id', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='viewer_id', full_name='icr.ImageSetResponse.viewer_id', index=1,
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
  serialized_start=483,
  serialized_end=532,
)

DESCRIPTOR.message_types_by_name['DicomDataRequest'] = _DICOMDATAREQUEST
DESCRIPTOR.message_types_by_name['DicomDataResponse'] = _DICOMDATARESPONSE
DESCRIPTOR.message_types_by_name['ImageGetRequest'] = _IMAGEGETREQUEST
DESCRIPTOR.message_types_by_name['ImageGetResponse'] = _IMAGEGETRESPONSE
DESCRIPTOR.message_types_by_name['ImageSetRequest'] = _IMAGESETREQUEST
DESCRIPTOR.message_types_by_name['ImageSetResponse'] = _IMAGESETRESPONSE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

DicomDataRequest = _reflection.GeneratedProtocolMessageType('DicomDataRequest', (_message.Message,), {
  'DESCRIPTOR' : _DICOMDATAREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomDataRequest)
  })
_sym_db.RegisterMessage(DicomDataRequest)

DicomDataResponse = _reflection.GeneratedProtocolMessageType('DicomDataResponse', (_message.Message,), {
  'DESCRIPTOR' : _DICOMDATARESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomDataResponse)
  })
_sym_db.RegisterMessage(DicomDataResponse)

ImageGetRequest = _reflection.GeneratedProtocolMessageType('ImageGetRequest', (_message.Message,), {
  'DESCRIPTOR' : _IMAGEGETREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.ImageGetRequest)
  })
_sym_db.RegisterMessage(ImageGetRequest)

ImageGetResponse = _reflection.GeneratedProtocolMessageType('ImageGetResponse', (_message.Message,), {
  'DESCRIPTOR' : _IMAGEGETRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.ImageGetResponse)
  })
_sym_db.RegisterMessage(ImageGetResponse)

ImageSetRequest = _reflection.GeneratedProtocolMessageType('ImageSetRequest', (_message.Message,), {
  'DESCRIPTOR' : _IMAGESETREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.ImageSetRequest)
  })
_sym_db.RegisterMessage(ImageSetRequest)

ImageSetResponse = _reflection.GeneratedProtocolMessageType('ImageSetResponse', (_message.Message,), {
  'DESCRIPTOR' : _IMAGESETRESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.ImageSetResponse)
  })
_sym_db.RegisterMessage(ImageSetResponse)



_HOROS = _descriptor.ServiceDescriptor(
  name='Horos',
  full_name='icr.Horos',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=535,
  serialized_end=893,
  methods=[
  _descriptor.MethodDescriptor(
    name='GetCurrentImageData',
    full_name='icr.Horos.GetCurrentImageData',
    index=0,
    containing_service=None,
    input_type=_DICOMDATAREQUEST,
    output_type=_DICOMDATARESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetCurrentImage',
    full_name='icr.Horos.GetCurrentImage',
    index=1,
    containing_service=None,
    input_type=_IMAGEGETREQUEST,
    output_type=_IMAGEGETRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='SetCurrentImage',
    full_name='icr.Horos.SetCurrentImage',
    index=2,
    containing_service=None,
    input_type=_IMAGESETREQUEST,
    output_type=_IMAGESETRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetROIList',
    full_name='icr.Horos.GetROIList',
    index=3,
    containing_service=None,
    input_type=roi__pb2._ROILISTREQUEST,
    output_type=roi__pb2._ROILIST,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetSelectedROI',
    full_name='icr.Horos.GetSelectedROI',
    index=4,
    containing_service=None,
    input_type=roi__pb2._ROIREQUEST,
    output_type=roi__pb2._ROI,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='UpdateROI',
    full_name='icr.Horos.UpdateROI',
    index=5,
    containing_service=None,
    input_type=roi__pb2._ROI,
    output_type=roi__pb2._UPDATEROIRESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_HOROS)

DESCRIPTOR.services_by_name['Horos'] = _HOROS

# @@protoc_insertion_point(module_scope)
