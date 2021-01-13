//
//  Adaptor.m
//  pyOsiriXII
//
//  Created by Richard Holbrey on 01/12/2020.
//

#import <Foundation/Foundation.h>
#include "Adaptor.h"

void
Adaptor::GetCurrentDicomFile( std::string& file ) {
    file = "help!";
}

//void
//Adaptor::Log( const char* txt ) {
//    pthread_mutex_lock( &lock );
//    [Console AddText:txt];
//    pthread_mutex_unlock( &lock );
//}
