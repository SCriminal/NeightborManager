//
//  SelectWhistleTypeVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectWhistleTypeVC.h"
//request
#import "RequestApi+Neighbor.h"

@interface SelectWhistleTypeVC ()
@property (nonatomic, strong) ModelTrolley *modelSelcted;

@end

@implementation SelectWhistleTypeVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SelectWhistleTypeCell class] forCellReuseIdentifier:@"SelectWhistleTypeCell"];
    //request
    [self requestList];
    [self addRefreshHeader];

}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"修改分类" rightTitle:@"完成" rightBlock:^{
        if (weakSelf.blockSelected) {
            weakSelf.blockSelected(weakSelf.modelSelcted);
        }
        [GB_Nav popViewControllerAnimated:true];
    }]];
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
    SelectWhistleTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectWhistleTypeCell"];
    ModelTrolley * model = self.aryDatas[indexPath.row];
    [cell resetCellWithModel:model];
    cell.ivSelected.highlighted = model.iDProperty == self.modelSelcted.iDProperty;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectWhistleTypeCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTrolley * model = self.aryDatas[indexPath.row];
    self.modelSelcted = model;
    [self.tableView reloadData];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestWhistleTypeDelegate:self
                                   success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelTrolley"];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end



@implementation SelectWhistleTypeCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIImageView *)ivSelected{
    if (_ivSelected == nil) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"select_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _ivSelected.widthHeight = XY(W(19),W(19));
    }
    return _ivSelected;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.ivSelected];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelTrolley *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.name fitTitle:UnPackStr(model.name) variable:W(320)];
    self.name.leftTop = XY(W(15),W(18));
    

    self.ivSelected.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    self.ivSelected.highlighted = model.selected;
    //设置总高度
    self.height = self.name.bottom + self.name.top;
}


@end
