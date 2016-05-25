//
//  WXBaseModel.h
//  MTWeibo
//  所有对象实体的基类

//  Created by zhangning on 14-9-22.
//  Copyright 2014年 zhangning All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXBaseModel : NSObject <NSCoding>


- (instancetype)initWithDataDic:(NSDictionary*)data;
- (void)setAttributes:(NSDictionary*)dataDic;


//获取归档数据: Model --> Data
- (NSData *)getArchivedData;

//解归档 Data ---> Model
+ (instancetype)archivedData:(NSData *)data;

@end
