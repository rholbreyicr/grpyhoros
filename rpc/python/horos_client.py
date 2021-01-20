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
"""The Python implementation of the GRPC horos.Horos client."""

from __future__ import print_function
import logging
import time

import grpc
import horos_pb2
import horos_pb2_grpc

import numpy as np
import SimpleITK as sitk
import matplotlib.pyplot as plt

import sys

def run_get_filename(port):
    # NOTE(gRPC Python Team): .close() is possible on a channel and should be
    # used in circumstances in which the with statement does not fit the needs
    # of the code.
    with grpc.insecure_channel('localhost:' + str(port)) as channel:
        stub = horos_pb2_grpc.HorosStub(channel)
        response = stub.GetCurrentImageFile(horos_pb2.DicomNameRequest(id='hurray for horos'))
    print("{run_get_filename}Client received (file): " + response.dicom_name)


def run_get_image(port):
    server_url = 'localhost:' + str(port)
    channel_opt = [('grpc.max_send_message_length', 512 * 1024 * 1024),
                   ('grpc.max_receive_message_length', 512 * 1024 * 1024)]
    channel = grpc.insecure_channel(server_url, options=channel_opt)
    stub = horos_pb2_grpc.HorosStub(channel)

    img_response = stub.GetCurrentImage(horos_pb2.ImageGetRequest(id='hurray for horos'))
    print("{run_get_image}Client received (file): " + img_response.dicom_name)

    if not img_response.dicom_name.startswith( "Error: "):
        print("{run_get_image}Client received (img size X): " + str(img_response.image_size[0]))
        print("{run_get_image}Client received (img size Y): " + str(img_response.image_size[1]))

        img_data = img_response.data
        img_array = np.array( img_data )
        print( "{run_get_image}Image array shape: ",  img_array.shape )
        img = np.reshape(img_array,  (img_response.image_size[1], img_response.image_size[0]) )
        plt.imshow( img, cmap='binary' )
        plt.axis('off')
        plt.show()


if __name__ == '__main__':

    Port = 50051
    if len(sys.argv) > 1:
        Port = sys.argv[1]

    logging.basicConfig()
    run_get_filename(Port)
    #for i in range(1):
    run_get_image(Port)
    #    time.sleep(1)
