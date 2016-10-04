//
//  NextViewController.m
//  Push_Pop_Present_Dismiss_Animation
//
//  Created by 小超人 on 16/9/14.
//  Copyright © 2016年 云之君兮鹏. All rights reserved.
//

#import "NextViewController.h"
#import "PP_Transition.h"

@interface NextViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(dimissAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dimissAction:(UIButton *)sender
{
[self dismissViewControllerAnimated:YES completion:^{
    NSLog(@"----");
}];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"----------->Dissmiss 二级页面中");
    
    return [[PP_Transition alloc] initWithStytle:(AnimatedSceneDissmiss)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
