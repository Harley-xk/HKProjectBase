//
//  ViewController.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "ViewController.h"
#import "HKProjectBase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showProgress:(id)sender {
    
    [self showProgressHUDWithMessage:@"Hello world!"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeProgressHUDToFinishModeWithMessage:@"Show task finished!"];
    });
}

- (IBAction)showAlert:(id)sender {

    UIAlertView *alert = [UIAlertView alertWithTitle:@"Hello world!" message:@"World,I'm comming!" cancelButtonTitle:@"World,I'm comming!" otherButtonTitles:@[@"Haha",@"Hehe"]];
    [alert showWithCallback:^(NSUInteger index) {
        HKLog(@"Alert Index:", @" %lu",index);
    }];
}

- (IBAction)showActionSheet:(id)sender {

    UIActionSheet *actionSheet = [UIActionSheet actionSheetWithTitle:@"Hello world!" cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Haha",@"Hehe"]];
    actionSheet.destructiveButtonIndex = 1;
    [actionSheet showInView:self.view withCallback:^(NSUInteger index) {
        HKLog(@"ActionSheet Index:",@" %lu",index);
    }];
}

@end
