//
//  HomeViewController.m
//  JuJingTianXiaGHD
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "MyAccountViewController.h"
#import "HomeViewController.h"

@interface HomeViewController ()<WKScriptMessageHandler>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"myAccount"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"manageProducts"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"manageOrderList"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"myAccountCard"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"myErWeiMa"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"transports"];
    
    
    
}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"当前点击的是：%@",message.name);
    if ([message.name isEqualToString:@"myAccount"]) {
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"mybooks.html"] animated:YES];
    } else if ([message.name isEqualToString:@"manageProducts"]){
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"shangjia.html"] animated:YES];
    }else if ([message.name isEqualToString:@"manageOrderList"]){
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"order.html"] animated:YES];
    }else if ([message.name isEqualToString:@"myAccountCard"]){
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"bankcard.html"] animated:YES];
    }else if([message.name isEqualToString:@"myErWeiMa"]){
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"ewm.html"] animated:YES];
    }else if ([message.name isEqualToString:@"transports"]){
        [self.navigationController pushViewController:[MyAccountViewController sharedWithWebName:@"distribution.html"] animated:YES];
    }else{
        NSAssert(message.name!=nil, @"不是任何一个");
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
