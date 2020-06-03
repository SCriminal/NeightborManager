//
//  SelectCommunityCityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityCityVC.h"
#import "SelectCommunityCityView.h"
//select district vc
#import "SelectCommunityDistrictVC.h"

@interface SelectCommunityCityVC ()
@property (nonatomic, strong) UIImageView *BG;
@property (nonatomic, strong) UIView *viewHeader;

@end

@implementation SelectCommunityCityVC
- (UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [UIView new];
        UILabel * label = [UILabel new];
        label.backgroundColor = [UIColor colorWithHexString:@"#FFF4B6"];
        label.fontNum = F(14);
        label.textColor = COLOR_333;
        [label fitTitle:@"潍坊市" variable:0];
        label.widthHeight = XY(label.width + W(50), W(37));
        label.textAlignment = NSTextAlignmentCenter;
        label.leftTop = XY(W(20), W(20));
        [label addRoundCorner:UIRectCornerAllCorners radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D9D9D9"]];

        [_viewHeader addSubview:label];
        _viewHeader.widthHeight = XY(SCREEN_WIDTH, label.bottom +W(20));
        [_viewHeader addTarget:self action:@selector(cityClick)];
    }
    return _viewHeader;
}
- (UIImageView *)BG{
    if (!_BG) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"select_community_BG"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _BG;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.BG belowSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];

    //添加导航栏
    [self addNav];
    self.tableView.tableHeaderView = self.viewHeader;
    //table
    [self.tableView registerClass:[SelectCommunityCityCell class] forCellReuseIdentifier:@"SelectCommunityCityCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择城市" rightView:nil];
    nav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCommunityCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCommunityCityCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCommunityCityCell fetchHeight:self.aryDatas[indexPath.row]];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
- (void)cityClick{
    [GB_Nav pushVCName:@"SelectCommunityDistrictVC" animated:true];
}
@end
