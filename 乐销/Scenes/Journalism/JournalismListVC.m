//
//  JournalismListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "JournalismListVC.h"
//cell
#import "JournalismListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "JournalismDetailVC.h"
@interface JournalismListVC ()
@property (nonatomic, strong) NSString *navTitle;

@end

@implementation JournalismListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无内容"];
    }
    return _noResultView;
}
- (NSString *)navTitle{
    switch (self.type) {
        case ENUM_NEWS_LIST_DYNAMIC:
            return @"动态快报";
            break;
        case ENUM_NEWS_LIST_HELP:
            return @"帮助中心";
            break;
        case ENUM_NEWS_LIST_ABOUT:
        {
            NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
            return  [NSString stringWithFormat:@"关于%@",appName];
        }
            break;
            
        default:
            break;
    }
    return @"";
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[JournalismListCell class] forCellReuseIdentifier:@"JournalismListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    
    [self.view addSubview:[BaseNavView initNavBackTitle:self.navTitle rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JournalismListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JournalismListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JournalismListCell fetchHeight:self.aryDatas[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JournalismDetailVC * vc = [JournalismDetailVC new];
    vc.model = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];

}
#pragma mark request
- (void)requestList{
    NSString * categoryAlias = @"default";
    switch (self.type) {
        case ENUM_NEWS_LIST_DYNAMIC:
            categoryAlias = @"news";
            break;
        case ENUM_NEWS_LIST_HELP:
            categoryAlias = @"help";
            break;
        case ENUM_NEWS_LIST_ABOUT:
            categoryAlias = @"about";
            break;
        default:
            break;
    }
    [RequestApi requestNewsListWithScopeid:25 page:self.pageNum count:50 categoryAlias:categoryAlias delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
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
@end
