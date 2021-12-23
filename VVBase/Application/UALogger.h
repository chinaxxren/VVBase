
#ifndef UALogger_h
#define UALogger_h
    #ifdef DEBUG
        #define UALog(format, ...) NSLog((@"[文件:%s]" "[函数:%s]" "[行:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
    #else
        #define UALog(...);
    #endif
#endif /* UALogger_h */
