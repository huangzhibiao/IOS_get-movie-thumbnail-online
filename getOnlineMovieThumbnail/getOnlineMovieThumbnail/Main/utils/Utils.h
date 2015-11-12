//
//  Utils.h
//  getOnlineMovieThumbnail
//
//  Created by biao on 15/11/12.
//  Copyright © 2015年 forward_biao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width
#define THUMB @"/thumb"

@interface Utils : NSObject

@property(nonatomic,strong)NSOperationQueue* loadThumbnailQueue;

+(instancetype)getIntance;//获取单例
+(NSString*)dirDoc:(NSString*)dir;//获根目录下的某个文件
+(NSFileManager*)getOrCreateDir:(NSString*)dir;//获取某个目录。不存在就新建

@end
