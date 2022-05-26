.PHONY: gen clean test cert

#MY_PROTOC=/usr/local/grpc-1.34.0/release/static/bin/protoc
MY_PROTOC=${HOME}/working/grpyhoros/grpc/bin/protoc
SYS_PROTOC=`which protoc`

# Can't seem to make this work as intended on mac.... you'll probably have to set by hand
# (NOTE ALSO: need grpc package here, not just protobuf & compiler)
ifeq ($(shell test -f ${SYS_PROTOC} && echo -n yes),yes)
  #$(shell echo setting: ${SYS_PROTOC})
  PROTOC:=${SYS_PROTOC}
else
  #$(shell echo setting: ${MY_PROTOC})
  PROTOC:=${MY_PROTOC}
endif
#PROTOC=${MY_PROTOC}

PROTO_DIR=$(shell dirname ${PROTOC})

gen: horos.proto roi.proto
	echo Using protoc: ${PROTOC}
	echo Using proto-dir: ${PROTO_DIR}
	${PROTOC} -I . --grpc_out=cpp --plugin=protoc-gen-grpc=${PROTO_DIR}/grpc_cpp_plugin horos.proto
	#${PROTOC} -I . --grpc_out=cpp --plugin=protoc-gen-grpc=${PROTO_DIR}/grpc_cpp_plugin roi.proto
	${PROTOC} -I . --cpp_out=cpp horos.proto
	${PROTOC} -I . --cpp_out=cpp roi.proto
	${PROTOC} -I . --grpc_out=python --plugin=protoc-gen-grpc=${PROTO_DIR}/grpc_python_plugin horos.proto
	#${PROTOC} -I . --grpc_out=python --plugin=protoc-gen-grpc=${PROTO_DIR}/grpc_python_plugin roi.proto
	${PROTOC} -I . --python_out=python horos.proto
	${PROTOC} -I . --python_out=python roi.proto

clean:
	rm cpp/*.cc cpp/*.h python/*pb2.py python/*pb2_grpc.py

cert:
	cd cert; ./generate-cert.sh; cd ..
