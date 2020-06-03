//
//  QuestionnaireDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "QuestionnaireDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
//
#import "QuestionnaireDetailTopView.h"
#import "QuestionnaireDetailVoteView.h"
//yellow btn
#import "YellowButton.h"
//create archive
#import "CreateArchiveVC.h"

@interface QuestionnaireDetailVC ()
@property (nonatomic, strong) ModelQuestionnairDetail *modelDetail;
@property (nonatomic, strong) QuestionnaireDetailTopView *topView;
@property (nonatomic, strong) QuestionnaireDetailVoteView *voteView;
@property (nonatomic, strong) NSArray *aryAchives;

@end

@implementation QuestionnaireDetailVC


- (QuestionnaireDetailVoteView *)voteView{
    if (!_voteView) {
        _voteView = [QuestionnaireDetailVoteView new];
    }
    return _voteView;
}
- (QuestionnaireDetailTopView *)topView{
    if (!_topView) {
        _topView = [QuestionnaireDetailTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];

    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"议事厅" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestQuestionnaireDetailWithId:self.modelList.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelQuestionnairDetail * modelDetail = [ModelQuestionnairDetail modelObjectWithDictionary:response];
        self.modelDetail = modelDetail;
        
        [self.topView resetViewWithModel:self.modelDetail];
        self.tableView.tableHeaderView = self.topView;
        
        [self.voteView resetViewWithModel:self.modelDetail];
        self.tableView.tableFooterView = self.voteView;

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}


@end
