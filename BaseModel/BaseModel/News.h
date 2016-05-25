//
//  News.h
//  BaseModel
//
//  Created by zhangning on 15/5/25.
//  Copyright © 2015年 zhangning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXBaseModel.h"

@interface News : WXBaseModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *image;

@end
