//
//  WXBaseModel.m
//  MTWeibo
//
//  Created by zhangning on 14-9-22.
//  Copyright 2014年 zhangning All rights reserved.
//

#import "WXBaseModel.h"
#import <objc/runtime.h>

@implementation WXBaseModel

- (instancetype)initWithDataDic:(NSDictionary*)data {
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}


- (SEL)getSetterSelWithAttibuteName:(NSString*)attributeName {
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}

- (NSString *)description {

    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"{\n"];
    
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    for (int i=0; i<outCount; i++) {
        
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);  //属性名
        id valueObj = object_getIvar(self, ivar);  //取得属性的值
        
        [desc appendFormat:@"    %s=%@ \n",name,valueObj];
        
    }
    [desc appendFormat:@"}"];
    
    return desc;
}

- (void)setAttributes:(NSDictionary*)dataDic {
    
    //取得所有的属性名
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    for (int i=0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);  //属性名
        
        NSString *attName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        attName = [attName substringFromIndex:1];
        
        if (attName) {
            id objValue = dataDic[attName];
            
            if (objValue) {
                object_setIvar(self, ivar, objValue);
            }
        }
        
    }
    
}

- (id)initWithCoder:(NSCoder *)decoder {
	if(self = [super init]){
		
        //取得所有的属性名
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList(self.class, &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);  //属性名
            
            NSString *attName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            id valueObj = [decoder decodeObjectForKey:attName];
            if (valueObj) {
                object_setIvar(self, ivar, valueObj);
            }
        }
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //取得所有的属性名
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    for (int i=0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);  //属性名

        NSString *attName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        id valueObj = object_getIvar(self, ivar);
        if (valueObj) {
            [encoder encodeObject:valueObj forKey:attName];
        }
    }
}

//取得当前对象所有的属性名
- (NSArray<NSString *> *)getAttributeNames {
    
    //取得所有的属性名
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    
    NSMutableArray *attrNames = [NSMutableArray arrayWithCapacity:outCount];
    for (int i=0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);  //属性名
        NSString *attName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [attrNames addObject:attName];
    }
    
    return attrNames;
}

- (NSData*)getArchivedData {
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}

+ (instancetype)archivedData:(NSData *)data {
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


#ifdef _FOR_DEBUG_  
-(BOOL) respondsToSelector:(SEL)aSelector {  
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
    return [super respondsToSelector:aSelector];  
}  
#endif

@end
