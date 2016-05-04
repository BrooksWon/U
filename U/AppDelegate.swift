//
//  AppDelegate.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //下一版本最好增加3Dtouch
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
//    - (void)customizeAppearance {
//    // 设置导航条背景 和顶部文字样式
//    //    UIImage *navBg = [[UIImage imageNamed:@"navigationbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    UIImage *navBg = [self imageFromColor:[UIColor whiteColor] height:64];
//    [[UINavigationBar appearance] setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];
//    //    [[UINavigationBar appearance] setTitleTextAttributes:
//    //     [NSDictionary dictionaryWithObjectsAndKeys:
//    //      [UIColor blackColor],NSForegroundColorAttributeName,
//    //      [UIFont systemFontOfSize:18],NSFontAttributeName, nil]
//    //     ];
//    
//    //    UIImage *tabbarBg = [[UIImage imageNamed:@"tabbar_background"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    UIImage *tabbarBg = [self imageFromColor:[UIColor whiteColor] height:49];
//    [[UITabBar appearance] setBackgroundImage:tabbarBg];
//    
//    //    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    //    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
//    }
//    
//    //通过颜色来生成一个纯色图片
//    - (UIImage *)imageFromColor:(UIColor *)color height:(CGFloat)height{
//    
//    CGRect rect = CGRectMake(0, 0, self.window.frame.size.width,height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
//    }

}

