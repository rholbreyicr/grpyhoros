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




DESCRIPTOR = _descriptor.FileDescriptor(
  name='horos.proto',
  package='icr',
  syntax='proto3',
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_pb=b'\n\x0bhoros.proto\x12\x03icr\"\x1e\n\x10\x44icomNameRequest\x12\n\n\x02id\x18\x01 \x01(\t\"\'\n\x11\x44icomNameResponse\x12\x12\n\ndicom_name\x18\x01 \x01(\t\"\x1f\n\x11\x44icomImageRequest\x12\n\n\x02id\x18\x01 \x01(\t\"n\n\x12\x44icomImageResponse\x12\x12\n\ndicom_name\x18\x01 \x01(\t\x12\x12\n\nimage_size\x18\x02 \x03(\x05\x12\x12\n\nvoxel_size\x18\x03 \x03(\x02\x12\x0e\n\x06origin\x18\x04 \x03(\x02\x12\x0c\n\x04\x64\x61ta\x18\x05 \x03(\x02\x32\x95\x01\n\x05Horos\x12\x46\n\x13GetCurrentImageFile\x12\x15.icr.DicomNameRequest\x1a\x16.icr.DicomNameResponse\"\x00\x12\x44\n\x0fGetCurrentImage\x12\x16.icr.DicomImageRequest\x1a\x17.icr.DicomImageResponse\"\x00\x62\x06proto3'
)




_DICOMNAMEREQUEST = _descriptor.Descriptor(
  name='DicomNameRequest',
  full_name='icr.DicomNameRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.DicomNameRequest.id', index=0,
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
  serialized_start=20,
  serialized_end=50,
)


_DICOMNAMERESPONSE = _descriptor.Descriptor(
  name='DicomNameResponse',
  full_name='icr.DicomNameResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='dicom_name', full_name='icr.DicomNameResponse.dicom_name', index=0,
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
  serialized_start=52,
  serialized_end=91,
)


_DICOMIMAGEREQUEST = _descriptor.Descriptor(
  name='DicomImageRequest',
  full_name='icr.DicomImageRequest',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='id', full_name='icr.DicomImageRequest.id', index=0,
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
  serialized_start=93,
  serialized_end=124,
)


_DICOMIMAGERESPONSE = _descriptor.Descriptor(
  name='DicomImageResponse',
  full_name='icr.DicomImageResponse',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  create_key=_descriptor._internal_create_key,
  fields=[
    _descriptor.FieldDescriptor(
      name='dicom_name', full_name='icr.DicomImageResponse.dicom_name', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=b"".decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='image_size', full_name='icr.DicomImageResponse.image_size', index=1,
      number=2, type=5, cpp_type=1, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='voxel_size', full_name='icr.DicomImageResponse.voxel_size', index=2,
      number=3, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='origin', full_name='icr.DicomImageResponse.origin', index=3,
      number=4, type=2, cpp_type=6, label=3,
      has_default_value=False, default_value=[],
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      serialized_options=None, file=DESCRIPTOR,  create_key=_descriptor._internal_create_key),
    _descriptor.FieldDescriptor(
      name='data', full_name='icr.DicomImageResponse.data', index=4,
      number=5, type=2, cpp_type=6, label=3,
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
  serialized_start=126,
  serialized_end=236,
)

DESCRIPTOR.message_types_by_name['DicomNameRequest'] = _DICOMNAMEREQUEST
DESCRIPTOR.message_types_by_name['DicomNameResponse'] = _DICOMNAMERESPONSE
DESCRIPTOR.message_types_by_name['DicomImageRequest'] = _DICOMIMAGEREQUEST
DESCRIPTOR.message_types_by_name['DicomImageResponse'] = _DICOMIMAGERESPONSE
_sym_db.RegisterFileDescriptor(DESCRIPTOR)

DicomNameRequest = _reflection.GeneratedProtocolMessageType('DicomNameRequest', (_message.Message,), {
  'DESCRIPTOR' : _DICOMNAMEREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomNameRequest)
  })
_sym_db.RegisterMessage(DicomNameRequest)

DicomNameResponse = _reflection.GeneratedProtocolMessageType('DicomNameResponse', (_message.Message,), {
  'DESCRIPTOR' : _DICOMNAMERESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomNameResponse)
  })
_sym_db.RegisterMessage(DicomNameResponse)

DicomImageRequest = _reflection.GeneratedProtocolMessageType('DicomImageRequest', (_message.Message,), {
  'DESCRIPTOR' : _DICOMIMAGEREQUEST,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomImageRequest)
  })
_sym_db.RegisterMessage(DicomImageRequest)

DicomImageResponse = _reflection.GeneratedProtocolMessageType('DicomImageResponse', (_message.Message,), {
  'DESCRIPTOR' : _DICOMIMAGERESPONSE,
  '__module__' : 'horos_pb2'
  # @@protoc_insertion_point(class_scope:icr.DicomImageResponse)
  })
_sym_db.RegisterMessage(DicomImageResponse)



_HOROS = _descriptor.ServiceDescriptor(
  name='Horos',
  full_name='icr.Horos',
  file=DESCRIPTOR,
  index=0,
  serialized_options=None,
  create_key=_descriptor._internal_create_key,
  serialized_start=239,
  serialized_end=388,
  methods=[
  _descriptor.MethodDescriptor(
    name='GetCurrentImageFile',
    full_name='icr.Horos.GetCurrentImageFile',
    index=0,
    containing_service=None,
    input_type=_DICOMNAMEREQUEST,
    output_type=_DICOMNAMERESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
  _descriptor.MethodDescriptor(
    name='GetCurrentImage',
    full_name='icr.Horos.GetCurrentImage',
    index=1,
    containing_service=None,
    input_type=_DICOMIMAGEREQUEST,
    output_type=_DICOMIMAGERESPONSE,
    serialized_options=None,
    create_key=_descriptor._internal_create_key,
  ),
])
_sym_db.RegisterServiceDescriptor(_HOROS)

DESCRIPTOR.services_by_name['Horos'] = _HOROS

# @@protoc_insertion_point(module_scope)
