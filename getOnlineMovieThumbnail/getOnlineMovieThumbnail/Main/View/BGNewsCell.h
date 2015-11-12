//
//  BGNewsCell.h
//  golo
//
//  Created by biao on 15/9/28.
//  Copyright (c) 2015年 forward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGNews.h"
@interface BGNewsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) BGNews *news;
@end
