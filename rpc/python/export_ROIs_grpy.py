# Copyright 2015 gRPC authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""The Python implementation of the GRPC pyOsiriX client."""

#from __future__ import print_function
#import logging
#import time

import grpc
import horos_pb2
import horos_pb2_grpc
import roi_pb2

import numpy as np
import SimpleITK as sitk
#import matplotlib.pyplot as plt
#import matplotlib.pyplot as pl

import sys
import pydicom as dicom

import os, re
from os.path import expanduser


def run_get_data(port):
    # NOTE(gRPC Python Team): .close() is possible on a channel and should be
    # used in circumstances in which the with statement does not fit the needs
    # of the code.
    """
    GetCurrentImageData is being tested here: an image is retrieved and displayed
    :param port:
    :return: A DicomDataRequest object. If 'with_file_list' is supplied as the string
    arg, the source image list is also returned
    """
    with grpc.insecure_channel('localhost:' + str(port), options=[('grpc.enable_http_proxy', 0), ]) as channel:
        stub = horos_pb2_grpc.HorosStub(channel)
        response = stub.GetCurrentImageData(horos_pb2.DicomDataRequest(id='with_file_list'))

    if not response.id.startswith("<Error>"):
        print("{run_get_data} Current dicom file: " + response.id)
        print("  patient_id: " + response.patient_id)
        print("  study_uid: " + response.study_instance_uid)
        print("  series_uid: " + response.series_instance_uid)
        print("  with: " + str(len(response.file_list)) + " files in selected series:- ")
        #for _file in response.file_list:
        #    print( _file )
    # AC change
    return response.file_list


def run_get_roi_as_xml(port):
    server_url = 'localhost:' + str(port)
    channel_opt = [('grpc.enable_http_proxy', 0), ]
    channel = grpc.insecure_channel(server_url, options=channel_opt)
    stub = horos_pb2_grpc.HorosStub(channel)

    # slice = stub.GetSliceROIs( roi_pb2.ROIRequest(id='...') )
    # if not slice.id.startswith("<Error>"):
    #     for _roi in slice.roi_list:
    #         print("{run_get_roi} Client received (roi): " + _roi.id)
    #         print(" (color): red " + str(_roi.color.r) +
    #               " green " + str(_roi.color.g) +
    #               " blue " + str(_roi.color.b))
    #         print(" (thickness):" + str(_roi.thickness) )
    #         print(" (points): " + str( len(_roi.point_list) ) )
    #         for _pt in _roi.point_list:
    #             print( str(_pt.x) + ", " + str(_pt.y) )
    # else:
    #     print( "{run_get_roi} error at: " + slice.id )
    response = stub.GetROIsAsList( roi_pb2.ROIListRequest(id='...') )
    print( "{run_get_roi/xml} returned: " + response.id )

def run_get_roi_as_image(port):
    server_url = 'localhost:' + str(port)
    channel_opt = [('grpc.enable_http_proxy', 0), ]
    channel = grpc.insecure_channel(server_url, options=channel_opt)
    stub = horos_pb2_grpc.HorosStub(channel)

    # slice = stub.GetSliceROIs( roi_pb2.ROIRequest(id='...') )
    # if not slice.id.startswith("<Error>"):
    #     for _roi in slice.roi_list:
    #         print("{run_get_roi} Client received (roi): " + _roi.id)
    #         print(" (color): red " + str(_roi.color.r) +
    #               " green " + str(_roi.color.g) +
    #               " blue " + str(_roi.color.b))
    #         print(" (thickness):" + str(_roi.thickness) )
    #         print(" (points): " + str( len(_roi.point_list) ) )
    #         for _pt in _roi.point_list:
    #             print( str(_pt.x) + ", " + str(_pt.y) )
    # else:
    #     print( "{run_get_roi} error at: " + slice.id )
    response = stub.GetROIsAsImage( roi_pb2.ROIListRequest(id='...') )
    print( "{run_get_roi/image} returned: " + response.id )
    print( "{run_get_roi/image} got file: " + response.output_filepath )
    # AC change
    return str(response.output_filepath)


#--------------------------------------------------------------
# export funcs

def reduce_dimension_3(im, dim=2):
    # Removes the last dimension of a 3D sitk image
    sz = list(im.GetSize())
    sz[dim] = 0
    return sitk.Extract(im, sz, [0 for i in range(len(sz))])

def resample_2D_slice(im, im_0):
    im = sitk.Resample(im, im_0, sitk.AffineTransform(2), sitk.sitkLinear, 0.0, sitk.sitkFloat32)
    return im

def dicom_tag_exists(dicom, group, element):
    if [group, element] in dicom:
        return True

def get_b_value_from_siemens_sequence_name(dicom):
    sequence_name = dicom[0x18, 0x24].value
    b_value_string = re.findall(r'\d+', sequence_name)[-1]
    b_value = float(b_value_string)
    return b_value

def get_siemens_b_value(dicom):
    if dicom_tag_exists(dicom, 0x19, 0x100c):
        return float(dicom[0x19, 0x100c].value)
    if dicom_tag_exists(dicom, 0x18, 0x9087):
        return float(dicom[0x18, 0x9087].value)
    if dicom_tag_exists(dicom, 0x18, 0x24):
        b_value = get_b_value_from_siemens_sequence_name(dicom)
        return b_value


if __name__ == '__main__':

    Port = 50051
    print( "Usage: " + sys.argv[0] + " [port-number] [keep-regions Y/y]" )

    if len(sys.argv) > 1:
        Port = sys.argv[1]

    keep_regions = False
    if len(sys.argv) > 2:
        keep_regions = True

    list_dcm_files = run_get_data(Port)
    path_ROIs_mask = run_get_roi_as_image(Port)

    print('path ROIs mask:', path_ROIs_mask)
    mask = sitk.ReadImage(path_ROIs_mask)
    print('mask size:', mask.GetSize())
    print('mask spacing:', mask.GetSpacing())

    ####### Turn into Numpy arrays and sort by location
    b_value_slice_locs = []
    b_value_pix = []
    for i in range(len(list_dcm_files)):
        dcm = dicom.read_file(list_dcm_files[i])
        b_value_slice_locs.append(dcm['SliceLocation'].value)
        b_value_pix.append(dcm.pixel_array)

    idx = np.argsort(b_value_slice_locs)
    b_value_pix = np.array(b_value_pix)[idx]
    b_value_slice_locs = np.array(b_value_slice_locs)[idx]

    ### no need it?
    mask_arrays = sitk.GetArrayFromImage(mask)
    mask_arrays = np.array(mask_arrays)[idx]

    sitk_images = []
    for i in range(mask_arrays.shape[0]):
        sitk_images.append(list_dcm_files[int(idx[i])])

    ####### Find the min/max slice locations to be considered, and the slice thickness
    minSL = np.min(b_value_slice_locs)
    maxSL = np.max(b_value_slice_locs)
    print('min slice loc:', minSL)
    print('max slice loc', maxSL)

    # Find the desired slice thickness
    st = float(dicom.read_file(list_dcm_files[0])['SliceThickness'].value)
    print('slice thickness:', st)

    # These are the slice locations we are going to generate
    sl_locs = np.arange(minSL, maxSL, st) #### here the one slice difference with cpp!!!
    n_slices = len(sl_locs)
    print('nb of slices that will generate:', n_slices)

    # The 'base' image -> just used for resampling each slice
    im_0 = sitk.ReadImage(sitk_images[0])
    im_0 = reduce_dimension_3(im_0)

    # Create 2D resampled images and masks
    resampled_slices_mask = np.empty(len(b_value_slice_locs), dtype=object)

    n_b_slices = len(b_value_slice_locs)
    resampled_slices = np.empty(n_b_slices, dtype=object)

    for i in range(n_b_slices):
        im = sitk.ReadImage(sitk_images[i])
        im = reduce_dimension_3(im)

        resampled_slices[i] = resample_2D_slice(im, im_0)

        mask_im = sitk.GetImageFromArray(mask_arrays[i])
        mask_im.CopyInformation(im)

        resampled_slices_mask[i] = resample_2D_slice(mask_im, im_0)

    # Now create resampled images
    b_value_volumes_resampled = np.zeros(np.r_[n_slices, im_0.GetSize()[::-1]])
    b_value_volumes_resampled_mask = np.zeros(np.r_[n_slices, im_0.GetSize()[::-1]])

    # The weighting tolerance for slices either side
    tol = 0.95
    for i in range(0, n_slices):
        sl = sl_locs[i]

        sl_diff = np.abs(b_value_slice_locs - sl) + 1e-10  # Small eps to avoid 0's
        weights = 1.0 / sl_diff
        weights = weights / np.sum(weights)

        # Find which slices matter
        idx = weights > tol * np.max(weights)
        weights = weights[idx]
        weights = weights / np.sum(weights)  # Renormalize
        b_sub = resampled_slices[idx]
        mask_sub = resampled_slices_mask[idx]

        # Create a weighted average image
        im_new = 0.0
        for k in range(len(b_sub)):
            im_new = b_sub[k] * weights[k] + im_new
        mask_new = 0.0
        for k in range(len(mask_sub)):
            mask_new = mask_sub[k] * weights[k] + mask_new

        arr = sitk.GetArrayFromImage(im_new)
        b_value_volumes_resampled[i, :, :] = arr
        arr = sitk.GetArrayFromImage(mask_new)
        b_value_volumes_resampled_mask[i, :, :] = arr

    # Create an image from the array
    im = sitk.GetImageFromArray(b_value_volumes_resampled)

    patient_id = dicom.read_file(list_dcm_files[0])['PatientID'].value
    study_date = dicom.read_file(list_dcm_files[0])['StudyDate'].value

    directory = "%s/Desktop/output_mha/%s/%s" % (expanduser("~"), patient_id, study_date)
    if not os.path.exists(directory):
        os.makedirs(directory)

    b_value = get_siemens_b_value(dicom.read_file(list_dcm_files[0]))

    # Now set the parameters.  For now this is the best I can think of.
    # It assumes something about the orientation!
    im.SetDirection((1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0))
    im.SetOrigin(tuple(np.r_[im_0.GetOrigin(), minSL]))
    im.SetSpacing(tuple(np.r_[im_0.GetSpacing(), st]))
    im.SetMetaData("date", study_date)
    im.SetMetaData("patient_id", patient_id)
    im.SetMetaData("b_value", "%d" % b_value)
    sitk.WriteImage(im, os.path.join(directory, "%d.mha" % b_value))

    # The same for the mask
    if keep_regions:
        im = sitk.GetImageFromArray(b_value_volumes_resampled_mask)
    else:
        fin_mask = np.where(b_value_volumes_resampled_mask>0,1,0)
        im = sitk.GetImageFromArray(fin_mask)
    im.SetDirection((1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0))
    im.SetOrigin(tuple(np.r_[im_0.GetOrigin(), minSL]))
    im.SetSpacing(tuple(np.r_[im_0.GetSpacing(), st]))
    im.SetMetaData("date", study_date)
    im.SetMetaData("patient_id", patient_id)
    im.SetMetaData("b_value", "mask")
    sitk.WriteImage(im, os.path.join(directory, "mask.mha"))






