//
//  ViewController.m
//  CXActionSheetView
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "ViewController.h"
#import "ActionSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    [ActionSheetView showActionSheetViewForTitles:@[@"sss",@"223",@"2323",@"+++"] sheetBlock:^(NSInteger select) {
        NSLog(@"%ld",(long)select);
    }];
}

@end
