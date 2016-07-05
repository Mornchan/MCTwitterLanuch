//
//  AppDelegate.m
//  LikeTwitterLogin
//
//  Created by MornChan on 16/6/24.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@property(strong,nonatomic) CAShapeLayer * backLayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController * vc = [[ViewController alloc]init];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithRed:252/255.0f green:106/255.0f blue:8/225.0f alpha:1.0];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    UIView * backLayer = [[UIView alloc]initWithFrame:vc.view.bounds];
    backLayer.backgroundColor = [UIColor whiteColor];
    [vc.view addSubview:backLayer];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.contents = (id)[UIImage imageNamed:@"logo"].CGImage;
    maskLayer.position = vc.view.center;
    maskLayer.bounds = CGRectMake(0, 0, 59, 59);
    vc.view.layer.mask = maskLayer;
    
    CAKeyframeAnimation * logoKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    logoKeyFrameAnimation.delegate = self;
    CGRect initRect = maskLayer.frame;
    CGRect beforeRect = CGRectMake(0, 0, 20, 20);
    CGRect afterRect = CGRectMake(0, 0, 2000, 2000);
    logoKeyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    logoKeyFrameAnimation.values = @[[NSValue valueWithCGRect:initRect],[NSValue valueWithCGRect:beforeRect],[NSValue valueWithCGRect:afterRect]];
    logoKeyFrameAnimation.fillMode = kCAFillModeForwards;
    logoKeyFrameAnimation.removedOnCompletion = NO;
    logoKeyFrameAnimation.duration = 1.0f;
    logoKeyFrameAnimation.beginTime = CACurrentMediaTime() + 1.0f;
    
    [maskLayer addAnimation:logoKeyFrameAnimation forKey:@"logoFirstAnimation"];
    vc.view.transform = CGAffineTransformMakeScale(1.05, 1.05);
    [UIView animateWithDuration:0.2 delay:1.75f options:UIViewAnimationOptionCurveLinear animations:^{
        backLayer.alpha = 0.0;
        vc.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [backLayer removeFromSuperview];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    NSLog(@"is %@",[anim valueForKey:@"logoFirstAnimation"]);
//    if ([anim valueForKey:@"logoFirstAnimation"]) {
//        
//        [self.backLayer removeFromSuperlayer];
//    }
//}

@end
