//
//  Macro.h
//  CHKCalendar
//
//  Created by 尊旅环球游 on 2017/7/5.
//  Copyright © 2017年 chk. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define UIColorFromHN(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FontSize(size) [UIFont systemFontOfSize:size]

#define weak(obj) __weak typeof(obj) Weak_##obj = obj;
#define strong(obj) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(obj) obj = Weak_##obj; \
_Pragma("clang diagnostic pop")

#endif /* Macro_h */
