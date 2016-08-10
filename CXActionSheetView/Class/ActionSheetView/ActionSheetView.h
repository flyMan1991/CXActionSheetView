//
//  ActionSheetView.h
//  转场动画
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SheetBlock) (NSInteger select);
@interface ActionSheetView : UIView
@property (nonatomic,copy)SheetBlock sheetBlock;
+ (void)showActionSheetViewForTitles:(NSArray *)titles sheetBlock:(SheetBlock)block;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
@end
