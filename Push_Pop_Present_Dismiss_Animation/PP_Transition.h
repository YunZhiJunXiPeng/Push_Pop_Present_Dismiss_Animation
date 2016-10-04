//
//  PP_PopOrPush.h
//  Push_Pop_Present_Dismiss_Animation
//
//  Created by 小超人 on 16/9/13.
//  Copyright © 2016年 云之君兮鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> //导入 UIKit 框架

// 写个枚举判断使用场景
typedef NS_OPTIONS(NSUInteger, AnimatedScene)
{
    AnimatedScenePush = 0,         // 值为 0
    AnimatedScenePop = 1 << 0,     // 值为 2 的 0次
    AnimatedScenePresent = 1 << 1, // 值为 2 的 1次
    AnimatedSceneDissmiss = 1 << 2 // 值为 2 的 2次
};

// 遵守一个转场的动画协议
@interface PP_Transition : NSObject<UIViewControllerAnimatedTransitioning>

// 自定义初始化方法
- (instancetype)initWithStytle:(AnimatedScene)scene;

@end