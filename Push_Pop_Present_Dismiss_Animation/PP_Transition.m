//
//  PP_PopOrPush.m
//  Push_Pop_Present_Dismiss_Animation
//
//  Created by 小超人 on 16/9/13.
//  Copyright © 2016年 云之君兮鹏. All rights reserved.
//

#import "PP_Transition.h"


#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width
@interface PP_Transition ()
{
    AnimatedScene _scenceStyle;
}

@end

@implementation PP_Transition

- (instancetype)initWithStytle:(AnimatedScene)scene
{
    if (self = [super init])
    {
        _scenceStyle = scene;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    // 获取到 containerView视图 （我们动画发生的载体，需要把展示动画的View 添加上去）
//    UIView *containerView = [transitionContext containerView];
//    // 我们要去的 View
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    // 从哪个 View 去的
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    
//    
//    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
//    backView.backgroundColor = [UIColor colorWithRed:0.6867 green:0.5837 blue:1.0 alpha:0.5];
//    UIView *changeMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreenW, 50)];
//    
//    changeMaskView.backgroundColor = [UIColor grayColor];
//    //    判断用户使用的是push还是pop
// 
//    if (_scenceStyle == AnimatedScenePush)
//    {
//        [containerView addSubview:backView];
////        [containerView addSubview:sizeView];
//        [UIView animateWithDuration:1.0 animations:^{
//            fromView.transform = CGAffineTransformScale(fromView.transform, 0.5, 0.5);
//            backView.backgroundColor = [UIColor greenColor];
//        } completion:^(BOOL finished) {
//            
//            [containerView addSubview:changeMaskView];
//            [UIView animateWithDuration:0.5 animations:^{
//                changeMaskView.frame = CGRectMake(0, 64, kScreenW, kScreenH);
//            } completion:^(BOOL finished) {
//                [backView removeFromSuperview];
//                [changeMaskView removeFromSuperview];
//                //toView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//                [containerView addSubview:toView];
//                [transitionContext completeTransition:YES];
//            }];
//        }];
//        NSLog(@"----->Push----->");
//    }else
//    {
//        [containerView insertSubview:toView belowSubview:fromView];
//        backView.backgroundColor = [UIColor purpleColor];
//        [containerView insertSubview:backView belowSubview:toView];
//        
//        [UIView animateWithDuration:1.0 animations:^{
//            
//            fromView.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH);
//        
//        }completion:^(BOOL finished) {
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                toView.transform = CGAffineTransformMakeScale(1, 1);
//                
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.3 animations:^{
//                    [backView removeFromSuperview];
//                } completion:^(BOOL finished) {
//                    [transitionContext completeTransition:YES];
//                }];
//                
//            }];
//            
//        }];
//        NSLog(@"----->Pop---->");
//    }
//}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 获取到 containerView视图 （我们动画发生的载体，需要把展示动画的View 添加上去）
    UIView *containerView = [transitionContext containerView];
    // 我们要去的 View
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 从哪个 View 去的
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    switch (_scenceStyle)
    {
        case AnimatedScenePush:
        {// Push 动画 这里只是举个例子  动画效果可以自己去使用
            // 注意点： 一定要把目的视图（要去的 View） 添加到容器（containerView）上.
            [UIView animateWithDuration:1.0 animations:^{
                fromView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            } completion:^(BOOL finished) {
                [containerView addSubview:toView];
                // 这个方法大概就是完成过渡动画，更新内部视图，控制器状态的转变！
                [transitionContext completeTransition:YES];
            }];
            
            NSLog(@"Push 动画效果");
        }
           break;
        case AnimatedScenePop:
        {
            // Pop 动画
            [UIView animateWithDuration:1.0 animations:^{
                // 让当前的二级页面  从下方消失
                fromView.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH);
                
            } completion:^(BOOL finished) {
                
                [containerView addSubview:toView];
                
                [UIView animateWithDuration:1.0 animations:^{
                    // 让首级页面  由小变大
                    toView.transform = CGAffineTransformMakeScale(1, 1);
                    
                } completion:^(BOOL finished) {
                    
                    // 完成过度动画
                    [transitionContext completeTransition:YES];
                }];
            }];
            NSLog(@"Pop 动画效果");

        }
            
            break;
        case AnimatedScenePresent:
        {
            
            toView.frame = CGRectMake(kScreenW / 2.0 , kScreenH / 2.0, 0, 0);
            
            [containerView addSubview:toView];
            
            [UIView animateWithDuration:1.0 animations:^{
              
               toView.frame = CGRectMake(0 , 0, kScreenW, kScreenH);
            
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:YES];
            }];
            
            NSLog(@"Present 动画效果");
            

        }
            break;
        case AnimatedSceneDissmiss:
        {
          
            [UIView animateWithDuration:1.0 animations:^{
            // 让当前的二级页面  从上方消失
                fromView.frame = CGRectMake(0, -kScreenH, kScreenW, kScreenH);
                
            } completion:^(BOOL finished) {
                
                [containerView addSubview:toView];
            // 完成过度动画
                [transitionContext completeTransition:YES];
             
            }];
            NSLog(@"Dissmiss 动画效果");

        }
            break;
            
        default:
            break;
    }

}






@end
