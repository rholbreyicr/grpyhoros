.PHONY: gen clean server client test cert

PROTOC=/usr/local/grpc/bin

gen:
	${PROTOC}/protoc -I . --grpc_out=cpp --plugin=protoc-gen-grpc=${PROTOC}/grpc_cpp_plugin horos.proto
	${PROTOC}/protoc -I . --cpp_out=cpp horos.proto
	${PROTOC}/protoc -I . --cpp_out=cpp roi.proto
	${PROTOC}/protoc -I . --grpc_out=python --plugin=protoc-gen-grpc=${PROTOC}/grpc_python_plugin horos.proto
	${PROTOC}/protoc -I . --python_out=python horos.proto
	${PROTOC}/protoc -I . --python_out=python roi.proto

#clean:
#	rm cpp/*.cc python/*.py

#server1:
#	go run cmd/server/main.go -port 50051

#client:
#	go run cmd/client/main.go -address 0.0.0.0:8080

cert:
	cd cert; ./generate-cert.sh; cd ..
