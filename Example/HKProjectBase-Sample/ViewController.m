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
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField.placeholderColor = [UIColor redColor];
    
    HKLOG(@"Model", @"%@",[[UIDevice currentDevice] model]);
    
    HKGetFolderSize(HKDocumentsPath(), ^(long long size) {
        
    });
}

- (IBAction)showProgress:(id)sender {
    
//    [self showProgressHUDWithMessage:@"Hello world!"];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self changeProgressHUDToFinishModeWithMessage:@"Show task finished!"];
//    });
    
//    HKMakePhoneCall(@"10086",NO);
}

- (IBAction)showAlert:(id)sender {

    UIAlertController *alert = [UIAlertController alertViewWithTitle:@"Hello world!" message:@"World,I'm comming!"];
    [alert addCancelActionWithTitle:@"World,I'm comming!" handler:nil];
    [alert addDefaultActionWithTitle:@"Haha" handler:^(UIAlertAction * _Nonnull action) {
        HKLOG(@"Alert Haha", @"");
    }];
    [alert addDefaultActionWithTitle:@"Hehe" handler:^(UIAlertAction * _Nonnull action) {
        HKLOG(@"Alert Hehe", @"");
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)showActionSheet:(id)sender {

    UIAlertController *alert = [UIAlertController actonSheetWithTitle:@"Hello world!" message:@"World,I'm comming!"];
    [alert addCancelActionWithTitle:@"World,I'm comming!" handler:nil];
    [alert addDefaultActionWithTitle:@"Haha" handler:^(UIAlertAction * _Nonnull action) {
        HKLOG(@"ActonSheet Haha", @"");
    }];
    [alert addDefaultActionWithTitle:@"Hehe" handler:^(UIAlertAction * _Nonnull action) {
        HKLOG(@"ActonSheet Hehe", @"");
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
