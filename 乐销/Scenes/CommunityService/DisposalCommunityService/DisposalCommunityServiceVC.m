//
//  DisposalCommunityServiceVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "DisposalCommunityServiceVC.h"
#import "YellowButton.h"
#import "PlaceHolderTextView.h"
//request
#import "RequestApi+Neighbor.h"

@interface DisposalCommunityServiceVC ()
@property (nonatomic, strong) YellowButton *btn;
@property (nonatomic, strong) UILabel *result;
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) PlaceHolderTextView *textView;


@end

@implementation DisposalCommunityServiceVC
#pragma mark 懒加载
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(335) :W(45) :@"确认处理"];
        WEAKSELF
        _btn.blockClick = ^{
            [weakSelf requestDisposal];
        };
    }
    return _btn;
}
- (UILabel *)result{
    if (_result == nil) {
        _result = [UILabel new];
        _result.textColor = COLOR_333;
        _result.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _result.numberOfLines = 1;
        _result.lineSpace = 0;
        [_result fitTitle:@"处理结果" variable:0];

    }
    return _result;
}
- (UIView *)bg{
    if (_bg == nil) {
        _bg = [UIView new];
        _bg.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _bg.widthHeight = XY(W(345), W(200));
        [_bg     addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        

    }
    return _bg;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        //        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写处理信息结果"];
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
    [self.view addSubview:self.result];
    [self.view addSubview:self.bg];
    [self.view addSubview:self.textView];
    
    //刷新view

    self.result.leftTop = XY(W(25),W(25)+NAVIGATIONBAR_HEIGHT);

    self.bg.leftTop = XY(W(15),self.result.bottom+W(15));
    self.textView.widthHeight = XY(self.bg.width - W(30),self.bg.height - W(30));
    self.textView.leftTop = XY( self.bg.left + W(15),self.bg.top+W(15));
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.bg.bottom + W(35));

}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"问题处理" rightView:nil]];
}
- (void)requestDisposal{
    if (!isStr(self.textView.text)) {
        [GlobalMethod showAlert:self.textView.placeHolder.text];
        return;
    }
    [RequestApi requestServiceDisposalWithResult:self.textView.text areaId:0 identity:self.model.iDProperty scope:7 scopeId:5 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SERVICE_REFERSH object:nil];
        self.requestState = 1;
               [GlobalMethod showAlert:@"处理成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}
@end
