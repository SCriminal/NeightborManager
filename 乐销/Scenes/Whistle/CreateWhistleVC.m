//
//  CreateWhistleVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateWhistleVC.h"
#import "YellowButton.h"
#import "PlaceHolderTextView.h"
//request
#import "RequestApi+Neighbor.h"
#import "SelectDepartmentVC.h"

@interface CreateWhistleVC ()
@property (nonatomic, strong) YellowButton *btn;
@property (nonatomic, strong) UILabel *reason;
@property (nonatomic, strong) UILabel *department;
@property (nonatomic, strong) UILabel *selectDepartment;
@property (nonatomic, strong) UIView *bg0;
@property (nonatomic, strong) UIImageView *arrowRight;
@property (nonatomic, strong) NSMutableArray *arySelected;

@property (nonatomic, strong) UIView *bg1;
@property (nonatomic, strong) PlaceHolderTextView *textView;


@end

@implementation CreateWhistleVC
#pragma mark 懒加载
- (UIImageView *)arrowRight{
    if (_arrowRight == nil) {
        _arrowRight = [UIImageView new];
        _arrowRight.image = [UIImage imageNamed:@"arrow_right"];
        _arrowRight.widthHeight = XY(W(15),W(15));
    }
    return _arrowRight;
}
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(335) :W(45) :@"确认吹哨"];
        WEAKSELF
        _btn.blockClick = ^{
            [weakSelf requestCreate];
        };
    }
    return _btn;
}
- (UILabel *)reason{
    if (_reason == nil) {
        _reason = [UILabel new];
        _reason.textColor = COLOR_333;
        _reason.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _reason.numberOfLines = 1;
        _reason.lineSpace = 0;
        [_reason fitTitle:@"处理结果" variable:0];
        
    }
    return _reason;
}
- (UILabel *)department{
    if (_department == nil) {
        _department = [UILabel new];
        _department.textColor = COLOR_333;
        _department.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _department.numberOfLines = 1;
        _department.lineSpace = 0;
        [_department fitTitle:@"吹哨部门" variable:0];
        
    }
    return _department;
}
- (UILabel *)selectDepartment{
    if (_selectDepartment == nil) {
        _selectDepartment = [UILabel new];
        _selectDepartment.textColor = COLOR_999;
        _selectDepartment.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _selectDepartment.numberOfLines = 0;
        _selectDepartment.lineSpace = W(5);
        [_selectDepartment fitTitle:@"请选择吹哨部门" variable:0];
        
    }
    return _selectDepartment;
}
-(UIView *)bg0{
    if (_bg0 == nil) {
        _bg0 = [UIView new];
        _bg0.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _bg0.widthHeight = XY(W(345), W(41));
        [GlobalMethod setRoundView:_bg0 color:[UIColor colorWithHexString:@"#EFF2F1"] numRound:10 width:1];
        [_bg0 addTarget:self action:@selector(selectDepartmentClick)];
    }
    return _bg0;
}
- (UIView *)bg1{
    if (_bg1 == nil) {
        _bg1 = [UIView new];
        _bg1.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _bg1.widthHeight = XY(W(345), W(200));
        [_bg1  addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    }
    return _bg1;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        //        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写吹哨原因"];
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _textView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //添加subView
    [self.view addSubview:self.btn];
    [self.view addSubview:self.reason];
    [self.view addSubview:self.bg0];
    [self.view addSubview:self.department];
    [self.view addSubview:self.selectDepartment];
    [self.view addSubview:self.bg1];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.arrowRight];

    [self reconfigView];
    
}

- (void)reconfigView{
    //刷新view
    self.department.leftTop = XY(W(25),W(25)+NAVIGATIONBAR_HEIGHT);
    self.bg0.leftTop = XY(W(15),self.department.bottom+W(15));
    if (self.arySelected.count) {
        NSString * strName = [[self.arySelected fetchValues:@"name"] componentsJoinedByString:@","];
        self.selectDepartment.textColor = COLOR_333;
        [self.selectDepartment fitTitle:strName variable:SCREEN_WIDTH- W(100)];
    }else{
        self.selectDepartment.textColor = COLOR_999;
        [self.selectDepartment fitTitle:@"请选择吹哨部门" variable:SCREEN_WIDTH- W(100)];
    }
    self.selectDepartment.leftTop = XY(self.bg0.left + W(15), self.bg0.top+W(13));
    self.bg0.height = self.selectDepartment.height+W(26);
    self.arrowRight.rightCenterY = XY(self.bg0.right - W(15), self.bg0.centerY);
    
    
    self.reason.leftTop = XY(W(25),W(15)+self.bg0.bottom);
    
    self.bg1.leftTop = XY(W(15),self.reason.bottom+W(15));
    self.textView.widthHeight = XY(self.bg1.width - W(30),self.bg1.height - W(30));
    self.textView.leftTop = XY( self.bg1.left + W(15),self.bg1.top+W(15));
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.bg1.bottom + W(35));
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"发起吹哨" rightView:nil]];
}

- (void)requestCreate{
    if (self.arySelected.count == 0) {
        [GlobalMethod showAlert:@"请选择吹哨部门"];
        return;
    }
    if (!isStr(self.textView.text)) {
        [GlobalMethod showAlert:@"请填写吹哨原因"];
        return;
    }
   
    NSString * strCode = [[self.arySelected fetchValues:@"iDProperty"] componentsJoinedByString:@","];

    [RequestApi requestAddWhistleWithPushdescription:self.textView.text pushCode:strCode areaId:5 id:self.model.iDProperty scope:@"" scopeId:6 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GlobalMethod showAlert:@"吹哨成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)selectDepartmentClick{
    SelectDepartmentVC * selectVC = [SelectDepartmentVC new];
    WEAKSELF
    selectVC.blockSelected = ^(NSMutableArray *ary) {
        weakSelf.arySelected = ary;
        [weakSelf reconfigView];
    };
    selectVC.arySelected = [NSMutableArray arrayWithArray:self.arySelected];
    [GB_Nav pushViewController:selectVC animated:true];
}
@end
