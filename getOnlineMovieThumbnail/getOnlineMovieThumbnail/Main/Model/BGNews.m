//
//  BGNews.m
//  golo
//
//  Created by biao on 15/9/28.
//  Copyright (c) 2015年 forward. All rights reserved.
//

#import "BGNews.h"

@implementation BGNews

-(instancetype)initWithicon:(NSString *)icon{
    self = [self init];
    if(self){
        self.icon = icon;
    }
    return self;
}

+(instancetype)NewsWithicon:(NSString *)icon{
    return [[self alloc] initWithicon:icon];
}
@end
