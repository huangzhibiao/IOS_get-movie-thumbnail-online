//
//  BGNews.h
//  golo
//
//  Created by biao on 15/9/28.
//  Copyright (c) 2015年 forward. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGNews : NSObject
@property (copy, nonatomic) NSString *icon;
-(instancetype)initWithicon:(NSString*)icon;
+(instancetype)NewsWithicon:(NSString*)icon;
@end
