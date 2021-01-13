//
//  hello-from-cpp.cpp
//  pyOsiriXII
//
//  Created by Richard Holbrey on 16/11/2020.
//

#include "hello-from-cpp.hpp"

void print_hello( const char* who )
{
    std::cout << who << " says hello" << std::endl;
    
    std::ofstream fout( "/tmp/hello-cpp.txt" );
    fout << who << " says hello" << std::endl;
}


void* inc_x( void* x_void_ptr )
{
    /* increment x to 100 */
    long int *x_ptr = (long int *)x_void_ptr;
    for( int p=0; p<100; p++ )
    {
        *x_ptr = 0;
        for( int q=0; q<1000000; q++ )
        {
            *x_ptr += q;
        }
    }
        
    std::ofstream fout( "/tmp/hello-cpp.txt", std::ios::app );
    fout << "sum: " << *x_ptr << std::endl;

    /* the function must return something - NULL will do */
    return NULL;
}

int create_thread()
{

    long int x = 0, y = 0;

    /* show the initial values of x and y */
    printf("x: %ld, y: %ld\n", x, y);

    /* this variable is our reference to the second thread */
    pthread_t inc_x_thread;

    /* create a second thread which executes inc_x(&x) */
    if(pthread_create(&inc_x_thread, NULL, inc_x, &x)) {

    fprintf(stderr, "Error creating thread\n");
    return 1;

    }
    /* increment y to 100 in the first thread */
    while(++y < 100);

    printf("y increment finished\n");

    /* wait for the second thread to finish */
    if(pthread_join(inc_x_thread, NULL)) {

    fprintf(stderr, "Error joining thread\n");
    return 2;

    }

    /* show the results - x is now 100 thanks to the second thread */
    printf("x: %ld, y: %ld\n", x, y);

    return 0;

}
