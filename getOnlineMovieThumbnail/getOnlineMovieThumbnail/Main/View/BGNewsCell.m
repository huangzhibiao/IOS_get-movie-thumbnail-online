//
//  BGNewsCell.m
//  golo
//
//  Created by biao on 15/9/28.
//  Copyright (c) 2015年 forward. All rights reserved.
//

#import "BGNewsCell.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>

@interface  BGNewsCell()

@property(nonatomic,strong)NSFileManager* fm;

@end
@implementation BGNewsCell

-(NSFileManager *)fm{
    if (_fm == nil) {
        _fm = [Utils getOrCreateDir:[Utils dirDoc:THUMB]];//获取某个目录的管理，不存在就新建
    }
    return _fm;
}

- (void)setNews:(BGNews *)news
{
    _news = news;
    [self setUIImageViewCornerRadius];//设置UIImageView的圆角
   
    NSLog(@"缩略图路径 = %@",news.icon);
    
    NSString* fileName = [self getVideoThumbnailAbsolutePath];
    if ([self.fm fileExistsAtPath:fileName]) {
        [self setVideoThumbnailForDisk];
    }else{
        self.iconView.image = nil;
        [self setOnlineImageForQueueWith:self.news.icon];
    }

}

/**
 异步获取在线thumbnail图片
 */
-(void)setOnlineImageForQueueWith:(NSString*)path{
    NSBlockOperation *loadThumbnailOption = [NSBlockOperation blockOperationWithBlock:^{
        NSString* fileName = [self getVideoThumbnailAbsolutePath];
        NSLog(@"不存在缩略图路径: %@",fileName);
        //self.player.contentURL = [NSURL URLWithString:path];
        MPMoviePlayerController* MP = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:path]];
        MP.shouldAutoplay = NO;
        UIImage* image = [MP thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [imageData writeToFile:fileName atomically:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger count = [Utils getIntance].loadThumbnailQueue.operationCount;
            NSLog(@"当前下载线程数 = %d",count);
            if (count<=0) {
                [[Utils getIntance].loadThumbnailQueue cancelAllOperations];
                [Utils getIntance].loadThumbnailQueue = nil;
                NSLog(@"重新初始化现在线程队列.........");
            }
            [self.iconView setImage:image];
        });
    }];
    [[Utils getIntance].loadThumbnailQueue addOperation:loadThumbnailOption];
}


/**
 获取影片缩略图的绝对路径
 */
-(NSString*)getVideoThumbnailAbsolutePath{
    return [NSString stringWithFormat:@"%@/%@",[Utils dirDoc:THUMB],[[_news.icon componentsSeparatedByString:@"/"] lastObject]];
}
/**
 获取缓存在硬盘里的缩略图
 */
-(void)setVideoThumbnailForDisk{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* fileName = [self getVideoThumbnailAbsolutePath];
        NSLog(@"存在缩略图路径: %@",fileName);
        UIImage* image = [UIImage imageWithContentsOfFile:fileName];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.iconView setImage:image];
        });
    });
}

/**
 设置UIImageView的圆角
 */
-(void)setUIImageViewCornerRadius{
    if(self.iconView.layer.cornerRadius != 10){
        CALayer* la = [self.iconView layer];
        [la setMasksToBounds:YES];
        [la setCornerRadius:10.0];
        //NSLog(@"设置图片圆角.........");
    }
}
@end
