//
//  SafetyUnionMemberListVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "SafetyUnionMemberListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "RTCSampleChatViewController.h"
#import "SafetySearchView.h"
#import "SelectCommunityPickerView.h"

@interface SafetyUnionMemberListVC ()
@property (nonatomic, strong) SafetySearchView *searchView;
@property (nonatomic, assign) double estateID;
@end

@implementation SafetyUnionMemberListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无联盟成员"];
    }
    return _noResultView;
}
- (SafetySearchView *)searchView{
    if (!_searchView) {
        _searchView = [SafetySearchView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockClose = ^{
            [weakSelf removeSearchData];
        };
        _searchView.blockSearch = ^{
            [weakSelf searchClick];
        };
        
    }
    return _searchView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.searchView];
    self.tableView.top = self.searchView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.searchView.bottom;
    
    //table
    [self.tableView registerClass:[SafetyUnionMemberListCell class] forCellReuseIdentifier:@"SafetyUnionMemberListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"平安联盟" rightView:nil]];
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
    SafetyUnionMemberListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SafetyUnionMemberListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockRTC = ^(ModelSafetyUnion *item) {
        if ([item.account isEqualToString:[GlobalData sharedInstance].GB_UserModel.account]) {
            [GlobalMethod showAlert:@"不能给自己发视频"];
            return;
        }
        [weakSelf reqeustRTCToken:item];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SafetyUnionMemberListCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestSafetyUnionMemberListWithPage:self.pageNum count:50                                    estateId:self.estateID
 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelSafetyUnion"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

-(void)reqeustRTCToken:(ModelSafetyUnion *)model{
    [RequestApi requestRtcTokenWithUserid:model.userId  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelRTC * model = [ModelRTC modelObjectWithDictionary:response];
        RTCSampleChatViewController * vc = [RTCSampleChatViewController new];
        vc.model = model;
        [GB_Nav pushViewController:vc animated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

#pragma mark click
- (void)searchClick{
    SelectCommunityPickerView * viewSelect = [SelectCommunityPickerView new];
    WEAKSELF
    viewSelect.blockSeleted = ^(ModelUserAuthority *selected) {
        weakSelf.searchView.tfSearch.text = selected.name;
        weakSelf.searchView.iconClose.highlighted = true;
        weakSelf.estateID = selected.iDProperty;
        [weakSelf refreshHeaderAll];
    };
    viewSelect.blockCancelClick = ^{
        [weakSelf removeSearchData];
    };
    [self.view addSubview:viewSelect];
}
- (void)removeSearchData{
    self.searchView.tfSearch.text = nil;
           self.estateID = 0;
           self.searchView.iconClose.highlighted = false;
           [self refreshHeaderAll];
}
@end



@implementation SafetyUnionMemberListCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_logo color:[UIColor clearColor] numRound:_logo.width/2.0 width:0];
    }
    return _logo;
}
- (UILabel *)communityName{
    if (_communityName == nil) {
        _communityName = [UILabel new];
        _communityName.textColor = COLOR_333;
        _communityName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _communityName;
}
- (UILabel *)memberName{
    if (_memberName == nil) {
        _memberName = [UILabel new];
        _memberName.textColor = COLOR_999;
        _memberName.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _memberName;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"safetyUnion_phone"];
        _iconPhone.widthHeight = XY(W(25),W(25));
    }
    return _iconPhone;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = [UIColor colorWithHexString:@"#0086E4"];
        _phone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_phone fitTitle:@"电话" variable:0];
        
    }
    return _phone;
}
- (UIImageView *)iconRTC{
    if (_iconRTC == nil) {
        _iconRTC = [UIImageView new];
        _iconRTC.image = [UIImage imageNamed:@"rtc_video"];
        _iconRTC.widthHeight = XY(W(25),W(25));
    }
    return _iconRTC;
}
- (UILabel *)rtc{
    if (_rtc == nil) {
        _rtc = [UILabel new];
        _rtc.textColor = [UIColor colorWithHexString:@"#0086E4"];
        _rtc.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_rtc fitTitle:@"视频" variable:0];
        
    }
    return _rtc;
}
- (UIControl *)conRTC{
    if (_conRTC == nil) {
        _conRTC = [UIControl new];
        _conRTC.tag = 1;
        [_conRTC addTarget:self action:@selector(rtcClick) forControlEvents:UIControlEventTouchUpInside];
        _conRTC.backgroundColor = [UIColor clearColor];
    }
    return _conRTC;
}
- (UIControl *)conPhone{
    if (_conPhone == nil) {
        _conPhone = [UIControl new];
        _conPhone.tag = 1;
        [_conPhone addTarget:self action:@selector(phoneClick) forControlEvents:UIControlEventTouchUpInside];
        _conPhone.backgroundColor = [UIColor clearColor];
    }
    return _conPhone;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:self.communityName];
        [self.contentView addSubview:self.memberName];
        [self.contentView addSubview:self.iconPhone];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.iconRTC];
        [self.contentView addSubview:self.rtc];
        [self.contentView addSubview:self.conRTC];
        [self.contentView addSubview:self.conPhone];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelSafetyUnion *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.headUrl)] placeholderImage:[UIImage imageNamed:@"safetyUnion_logo"]];
    self.logo.leftTop = XY(W(15),W(15));
    [self.communityName fitTitle:UnPackStr(model.estateName) variable:W(200)];
    self.communityName.leftTop = XY(self.logo.right + W(10),self.logo.top+W(2));
    
    [self.memberName fitTitle:[NSString stringWithFormat:@"平安联盟队员：%@",isStr(model.name)?model.name:@"暂无"] variable:W(200)];
    self.memberName.leftBottom = XY(self.communityName.left,self.logo.bottom-W(2));
    
    self.iconRTC.rightTop = XY(SCREEN_WIDTH - W(15),self.logo.top+W(4));
    self.rtc.centerXTop = XY(self.iconRTC.centerX,self.iconRTC.bottom+W(5));
    self.conRTC.frame = CGRectInset(self.iconRTC.frame, -W(30), -W(30));
    
    self.iconPhone.rightTop = XY(self.iconRTC.left - W(30),self.self.iconRTC.top);
    self.phone.centerXTop = XY(self.iconPhone.centerX,self.iconPhone.bottom+W(5));
    self.conPhone.frame = CGRectInset(self.iconPhone.frame, -W(30), -W(30));
    
    //设置总高度
    self.height = [self.contentView addLineFrame:CGRectMake(W(15), self.logo.bottom + W(15), SCREEN_WIDTH - W(30), 1)];
}

- (void)rtcClick{
    if (self.blockRTC) {
        self.blockRTC(self.model);
    }
}
- (void)phoneClick{
    if (isStr(self.model.account)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.account];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }
}
@end
