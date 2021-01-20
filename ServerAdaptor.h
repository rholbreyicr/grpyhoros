//
//  ServerAdaptor.h
//  pyOsiriXII
//
//  Created by Richard Holbrey on 01/12/2020.
//

#ifndef ServerAdaptor_h
#define ServerAdaptor_h

//@class PyOsiriXIIFilter;
@class NSLock;

namespace icr {

/** \brief ServerAdaptor
        Communication object between server and plugin code (which usually has to be on the main thread).
 */
struct ServerAdaptor {

    void* Osirix;    ///< Initialized and owned by plugin represented by this member, which, in use,
                     ///< will be grpyOsiriXFilter* ..... void* here for 2 reasons:
                     ///< 1. testing with a dummy replacement
                     ///< 2. The server code makes use of 'callOnMainThread' functions which only need an (id) type
    
    NSLock* Lock;  ///< Mutex, owned by plugin, used to control access to Request & Response

    char Port[16];  ///< Initialized by plugin

    const void* Request;  ///<  C++ server request type (based on call type, owned by Server)
    void* Response;       ///<  C++ server response  type (based on call type, owned by Server)
};

}

#endif /* ServerAdaptor_h */
