//
//  ViewController.m
//  Push_Pop_Present_Dismiss_Animation
//
//  Created by 小超人 on 16/9/13.
//  Copyright © 2016年 云之君兮鹏. All rights reserved.
//
/**
 *  自定义转场动画
 主要是导航控制器的 Push 动画和 Pop 动画和普通控制器的Present和Dismiss动画，
 
 
 ----->方法步骤：
 

 
 主要就是通过控制器遵守UINavigationControllerDelegate (Pop 和 Push) UIViewControllerTransitioningDelegate(Present 和 Dissmiss)，并实现对应的方法，
 operation == UINavigationControllerOperationPush 或者 UINavigationControllerOperationPop 区分
 - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
 animationControllerForOperation:(UINavigationControllerOperation)operation
 fromViewController:(UIViewController *)fromVC
 toViewController:(UIViewController *)toVC
 
 Present:
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
 Dissmiss:
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
 
 
 
 返回一个遵守UIViewControllerAnimatedTransitioning协议的对象，而主要的动画实现就是写在这个对象当中
 -(NSTimeInterval)transitionDuration: transitionContext： 跳转的时间
 -(void)animateTransition: transitionContext 所要执行的动画 传入的参数是泛型的UIViewControllerContextTransitioning对象
 其中：
 containerView 是控制整个跳转的页面 API 描述 这个视图即是动画发生的地方（画布）（将要跳转到的控制器的view添加到画布上执行动画）
 fromViewController就是准备跳转的控制器，
 toViewController 就是要跳转到的控制器，
 


 */

/**
 1：Push和 Pop 动画需要在 push 所属的（要去的）控制器 和 pop 所属的（要回的）控制器里 实现导航控制器的代理以实现Push和Pop的动画，
 2：Present 和 Dismiss 动画只需要在 Presnent的时候设置代理，并实现present和dismiss的协议方法就好了
 */


#import "ViewController.h"
#import "PP_Transition.h"
#import "NextViewController.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    // Do any additional setup after loading the view, typically from a nib.
    // 设置 导航控制器代理完成 push 和 pop
    self.navigationController.delegate = self;
    // 设置 模态转场过渡代理
    //self.transitioningDelegate = self;
}

- (IBAction)push:(UIButton *)sender
{
    UIViewController *nvc = [[UIViewController alloc] init];
    nvc.title = @"Push页";
    nvc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:nvc animated:YES];

}
- (IBAction)present:(UIButton *)sender
{
   NextViewController *nvc = [[NextViewController alloc] init];
    nvc.title = @"Push页";
    nvc.view.backgroundColor = [UIColor yellowColor];
    // 这个是转场的关键代理
    nvc.transitioningDelegate = self;
    nvc.modalPresentationStyle = UIModalPresentationCustom;
    self.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nvc animated:YES completion:^{
        
    
    }];

}




// 导航控制器的跳转动画代理方法  在这里完成 Push 和 Pop 动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return operation == UINavigationControllerOperationPush ? [[PP_Transition alloc] initWithStytle:(AnimatedScenePush)] : [[PP_Transition alloc] initWithStytle:(AnimatedScenePop)];
}

// 完成转场 Present 动画代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"----------->Present 一级视图控制器中");
    return [[PP_Transition alloc] initWithStytle:(AnimatedScenePresent)];
}
// 转场 Dissmiss 动画 代理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"----------->Dissmiss 一级视图控制器中");
    return [[PP_Transition alloc] initWithStytle:(AnimatedSceneDissmiss)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
