//
//  ActionSheetView.m
//  转场动画
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "ActionSheetView.h"
#define  ActionHeigh  40.f
@interface ActionSheetView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGFloat _actionHeight;
    CGSize size;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,copy)NSArray * titles;
@end
@implementation ActionSheetView
ActionSheetView * sheetView;
+ (void)showActionSheetViewForTitles:(NSArray *)titles sheetBlock:(SheetBlock)block{
    UIWindow * keyWindow = [[UIApplication sharedApplication].windows firstObject];
    sheetView  = [[ActionSheetView alloc] initWithFrame:CGRectMake(0, 0, keyWindow.bounds.size.width, keyWindow.bounds.size.height) titles:titles];
    sheetView.sheetBlock = block;
    [keyWindow addSubview:sheetView];
    [sheetView createBaseUI];
    
}
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    // 背景蒙版
    [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];
    self.titles = [titles copy];
    CGFloat heigh = (titles.count + 1) * ActionHeigh + 5;
    _actionHeight = heigh >= 165 ? 165 : heigh;
    return self;
}
// 创建UI视图
- (void)createBaseUI {
    UIWindow * keyWindow = [[UIApplication sharedApplication].windows firstObject];
    [keyWindow addSubview:self.tableView];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.y  = self.frame.size.height - _actionHeight;
        self.tableView.frame = frame;
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
    
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, _actionHeight)];
        if (_actionHeight >= 165) {
            _tableView.scrollEnabled = YES;
        }else {
            _tableView.scrollEnabled = NO;
        }
        _tableView.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:1.0];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = ActionHeigh;
    }
    return _tableView;
}
#pragma mark UITableViewDelegate,UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titles.count > 0 ? 2 : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section > 0 ? 1 : self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString * title;
    title = indexPath.section > 0 ? @"取消" : self.titles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"选中");
    [self hiddenSheet];
    if (indexPath.section > 0) {
        return;
    }
    if (self.sheetBlock) {
        self.sheetBlock(indexPath.row);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section > 0 ? 5 : 0.0001 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
#pragma mark 隐藏actionsheet
- (void)hiddenSheet {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.tableView.frame;
        frame.origin.y = self.frame.size.height;
        self.tableView.frame = frame;
        self.alpha = 0;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end
