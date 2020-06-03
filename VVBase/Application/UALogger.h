
#ifndef UALogger_h
#define UALogger_h
    #import <NSLogger/NSLogger.h>
    #define UALog(...) LogMessageF( __FILE__,__LINE__,__FUNCTION__, NULL, 0, __VA_ARGS__)
#endif /* UALogger_h */
