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

def run_get_data(port):
    # NOTE(gRPC Python Team): .close() is possible on a channel and should be
    # used in circumstances in which the with statement does not fit the needs
    # of the code.
    #with grpc.insecure_channel('localhost:' + str(port)) as channel:
    with grpc.insecure_channel('localhost:' + str(port), options=[('grpc.enable_http_proxy', 0),]) as channel:
        stub = horos_pb2_grpc.HorosStub(channel)
        response = stub.GetCurrentImageData(horos_pb2.DicomDataRequest(id='with_file_list'))
    print("{run_get_data}Client received (file): " + response.id)
    print("{run_get_data}Client received (patient_id): " + response.patient_id)
    print("{run_get_data}Client received (study_uid): " + response.study_instance_uid)
    print("{run_get_data}Client received (series_uid): " + response.series_instance_uid)
    for _file in response.file_list:
        print( _file )

def run_get_image(port):
    server_url = 'localhost:' + str(port)
    channel_opt = [('grpc.max_send_message_length', 512 * 1024 * 1024),
                   ('grpc.max_receive_message_length', 512 * 1024 * 1024),
                   ('grpc.enable_http_proxy', 0)]
    #channel = grpc.insecure_channel(server_url, options=channel_opt)
    channel = grpc.insecure_channel('localhost:' + str(port), options=channel_opt)
    stub = horos_pb2_grpc.HorosStub(channel)

    response = stub.GetCurrentImage(horos_pb2.ImageGetRequest(id='hurray for horos'))
    print("{run_get_image}Client received (file): " + response.id)

    if not response.id.startswith( "<Error>"):
        print("{run_get_image}Client received (img size X): " + str(response.image_size[0]))
        print("{run_get_image}Client received (img size Y): " + str(response.image_size[1]))
        print("{run_get_image}Client received (viewer id): " + str(response.viewer_id))

        img_data = response.data
        img_array = np.array( img_data )
        print( "{run_get_image}Image array shape: ",  img_array.shape )
        img = np.reshape(img_array,  (response.image_size[1], response.image_size[0]) )
        plt.imshow( img, cmap='binary' )
        plt.axis('off')
        plt.show()

def run_set_image(port):
    server_url = 'localhost:' + str(port)
    channel_opt = [('grpc.max_send_message_length', 512 * 1024 * 1024),
                   ('grpc.max_receive_message_length', 512 * 1024 * 1024),
                   ('grpc.enable_http_proxy', 0)]
    channel = grpc.insecure_channel(server_url, options=channel_opt)
    stub = horos_pb2_grpc.HorosStub(channel)

    img_response = stub.GetCurrentImage(horos_pb2.ImageGetRequest(id='hurray for horos'))
    print("{run_set_image}Client received (file): " + img_response.id)

    if not img_response.id.startswith( "<Error>"):
        img_data = img_response.data
        img_array = np.array( img_data )
        print( "{run_set_image} multiplying by 2.... " )
        img_array = img_array * 2
        img_response.data[:] = img_array.tolist() # reassign the whole thing

        #stub.clear ??? 4290645 vs. 4194304 size error with larger images...
        set_response = stub.SetCurrentImage( img_response )
        print("{run_set_image}Client received set response): " + set_response.id)



if __name__ == '__main__':

    Port = 50052
    if len(sys.argv) > 1:
        Port = sys.argv[1]

    logging.basicConfig()
    run_get_data(Port)
    #for i in range(1):
    run_set_image(Port)
    run_get_image(Port)
    #    time.sleep(1)
