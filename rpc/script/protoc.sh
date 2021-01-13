#!/usr/local/bin/bash

##C++
## $ protoc -I ../../protos --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` ../../protos/route_guide.proto
## $ protoc -I ../../protos --cpp_out=. ../../protos/route_guide.proto
##
##python can do it like this
## $python -m grpc_tools.protoc -I../../protos --python_out=. --grpc_python_out=. ../../protos/route_guide.proto

## Running this command generates the following files in your current directory:
## 
##   xxxx.pb.h, the header which declares your generated message classes
##   xxxx.pb.cc, which contains the implementation of your message classes
##   xxxx.grpc.pb.h, the header which declares your generated service classes
##   xxxx.grpc.pb.cc, which contains the implementation of your service classes

# Note: if this script is in ~/bin, say, we have to specify the actual directories too eg.
#   from proto dir:
#   ~/bin/protoc `pwd` cpp `pwd`/route_guide.proto `pwd`

if [ $# -ne 4 ]; then
  echo "protoc <include-dirs> <cpp/python/objc> <xxxx.proto> <output-dir>"
  exit
fi

cd /usr/local/grpc-1.33.1/gnu-release/bin

PLUGIN='cpp'
if [ $2 == 'python' ]; then
  PLUGIN='python'
elif [ $2 == 'objc' ]; then
  PLUGIN='objective_c'
fi 


./protoc -I $1 --grpc_out=$4 --plugin=protoc-gen-grpc=./grpc_${PLUGIN}_plugin $3

if [ $2 == 'cpp' ]; then
  ./protoc -I $1 --cpp_out=$4 $3
elif [ $2 == 'python' ]; then
  ./protoc -I $1 --python_out=$4 $3
elif [ $2 == 'objc' ]; then
    ./protoc -I $1 --objc_out=$4 $3  
fi 


cd $OLDPWD
