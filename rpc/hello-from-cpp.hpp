//
//  hello-from-cpp.hpp
//  pyOsiriXII
//
//  Created by Richard Holbrey on 16/11/2020.
//

#ifndef hello_from_cpp_hpp
#define hello_from_cpp_hpp

#include <iostream>
#include <fstream>
#include <pthread.h>
#include <stdio.h>

void print_hello( const char* who );

/* this function is for calling on a pthread */
void* inc_x( void* x_void_ptr );

int create_thread();

#endif /* hello_from_cpp_hpp */
