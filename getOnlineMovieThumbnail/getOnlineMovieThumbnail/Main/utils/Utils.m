//
//  Utils.m
//  getOnlineMovieThumbnail
//
//  Created by biao on 15/11/12.
//  Copyright © 2015年 forward_biao. All rights reserved.
//

#import "Utils.h"
static Utils* myUtlis;

@implementation Utils

+(instancetype)getIntance{
    if (myUtlis == nil) {
        myUtlis = [[Utils alloc] init];
    }
    return myUtlis;
}

-(NSOperationQueue *)loadThumbnailQueue{
    if (_loadThumbnailQueue == nil) {
        _loadThumbnailQueue = [[NSOperationQueue alloc] init];
        _loadThumbnailQueue.maxConcurrentOperationCount = 1;
    }
    return _loadThumbnailQueue;
}

/**
 获取根目录下的某个路径
 */
+(NSString*)dirDoc:(NSString*)dir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [[paths objectAtIndex:0] stringByAppendingString:dir];
    return documentsDirectory;
}

/**
 判断一个目录，如果不存在就新建
 */
+(NSFileManager*)getOrCreateDir:(NSString*)dir{
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:dir]) {
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fm;
}

@end
