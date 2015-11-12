//
//  MainViewController.m
//  getOnlineMovieThumbnail
//
//  Created by biao on 15/11/12.
//  Copyright © 2015年 forward_biao. All rights reserved.
//

#import "MainViewController.h"
#import "Utils.h"
#import "BGNews.h"
#import "BGNewsCell.h"


@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView* collectView;
@property(nonatomic,strong)NSMutableArray* icons;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initCollectView];
}
/**
 根据自己的服务器来修改自己IP和视频访问路径
 */
-(NSMutableArray *)icons{
    if (_icons == nil) {
        NSString*  IP = @"http://192.168.2.138:8080/";
        
        _icons = [[NSMutableArray alloc] init];
        BGNews* new1 = [BGNews NewsWithicon:[NSString stringWithFormat:@"%@%@",IP,@"b1.MP4"]];
        [_icons addObject:new1];
        
        BGNews* new2 = [BGNews NewsWithicon:[NSString stringWithFormat:@"%@%@",IP,@"b2.MP4"]];
        [_icons addObject:new2];

        BGNews* new3 = [BGNews NewsWithicon:[NSString stringWithFormat:@"%@%@",IP,@"b3.MP4"]];
        [_icons addObject:new3];
        
        BGNews* new4 = [BGNews NewsWithicon:[NSString stringWithFormat:@"%@%@",IP,@"b4.MP4"]];
        [_icons addObject:new4];
    }
    return _icons;
}

/**
 初始化UICollectionView
 */
-(void)initCollectView{
    CGFloat Margin = 7;
    CGFloat W = (screenW - Margin*4)/3;
    CGFloat H = 1.2*W;
    CGRect rect = CGRectMake(Margin, 64, screenW - Margin*2, screenH - Margin*2);
    //初始化布局类(UICollectionViewLayout的子类)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(W, H);
    layout.minimumInteritemSpacing = Margin;//设置行间隔
    layout.minimumLineSpacing = Margin;//设置列间隔
    //初始化collectionView
    UICollectionView* collect = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    self.collectView = collect;
    //设置代理
    collect.delegate = self;
    collect.dataSource = self;
    collect.showsVerticalScrollIndicator = NO;
    // 注册cell
    [collect registerNib:[UINib nibWithNibName:@"BGNewsCell" bundle:nil] forCellWithReuseIdentifier:@"news"];
    //设置水平方向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置分页
    //self.collectView.pagingEnabled = YES;
    collect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collect];
}

#pragma -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.icons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"news";
    BGNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.news = self.icons[indexPath.item];    
    return cell;
}

@end
