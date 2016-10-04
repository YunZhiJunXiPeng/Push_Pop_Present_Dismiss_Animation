# Push_Pop_Present_Dismiss_Animation
跳转动画自定义方法，流程简单总结！
小结一下跳转页面的动画效果实现思路！
> 总结的转场动画是下面几个情况：
- 导航控制器的 Push 动画和 Pop 动画
- 普通控制器的 Present 动画和 Dismiss动画，

-----
>  ###思路简析：
- 跳转的控制器遵守 `UINavigationControllerDelegate`  协议，从而实现 Pop 和 Push 的跳转动画。

>```code
# 通过 operation == UINavigationControllerOperationPush 或者 UINavigationControllerOperationPop 区分是 Push 还是 Pop
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
 animationControllerForOperation:(UINavigationControllerOperation)operation
 fromViewController:(UIViewController *)fromVC
 toViewController:(UIViewController *)toVC```
- 跳转的控制器遵守`UIViewControllerTransitioningDelegate`协议， 从而实现 Present 和 Dissmiss跳转动画

>```code
# Present:
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
# Dissmiss:
 - (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;```

> - <big><u><b>上述的几个方法都是  返回一个遵守UIViewControllerAnimatedTransitioning协议的对象，而主要的动画实现就是写在这个对象当中！我们只要封装好这个类型的对象，在上述方法中返回对应实例对象就能实现动画效果！</big></u></b>

>```object
# UIViewControllerAnimatedTransitioning协议 主要实现两个方法
-(NSTimeInterval)transitionDuration: transitionContext： 跳转的时间
-(void)animateTransition: transitionContext 所要执行的动画在这里实现 
```
>>其中第二个方法传入的参数是泛型的`UIViewControllerContextTransitioning`对象
可以通过下面它的的实例方法获取我们需要展示动画的相关属性

```code

#  这个方法获得的是 控制整个跳转的页面 （API 描述：这个视图是动画发生的地方（画布））（将要跳转到的控制器的view添加到画布上执行动画）
- (nullable UIView *)containerView
#  Key 取值 UITransitionContextFromViewControllerKey  （源控制器）UITransitionContextToViewControllerKey（目标控制器）
- (nullable __kindof UIViewController *)viewControllerForKey:(NSString *)key
#  Key 取值  UITransitionContextFromViewKey（源视图）  UITransitionContextToViewKey（目标视图）
- (nullable __kindof UIView *)viewForKey:(NSString *)key

```


------
###简单效果展示：
![演示——跳转.gif](http://upload-images.jianshu.io/upload_images/1523603-841d6af2b7b0db2a.gif?imageMogr2/auto-orient/strip)
