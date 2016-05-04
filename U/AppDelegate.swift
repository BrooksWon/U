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
//        launchingAnimation()
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
    
//    func launchingAnimation(){
////        let viewSize = .window.bounds().size();
//        let launchingAnimationView = UIView.init(frame: window!.bounds)
//        let label = GlitchLabel.init(frame: CGRect.init(x: 10, y: window!.bounds.size.height/2-50/2.0, width: window!.bounds.size.width-10*2.0, height: 50.0))
//        label.text = "Hello World"
////        label.font = UIFont.init(name: "System Black", size: 50.0)
//        label.font = UIFont.systemFontOfSize(50.0)
////        label.backgroundColor = UIColor.blackColor()
////        label.textColor = UIColor.whiteColor()
//        launchingAnimationView.backgroundColor = UIColor.blackColor()
//        launchingAnimationView.addSubview(label)
//        
//        UIView.animateWithDuration(3.0, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
//            launchingAnimationView.alpha = 0.0
//            launchingAnimationView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1.0)
//            }) { (finished) in
//                launchingAnimationView.removeFromSuperview()
//        }
    
//    }
    
    //- (void)addLoadingAnimation {
    //    CGSize viewSize = self.window.bounds.size;
    //    NSString *viewOrientation = @"Portrait";  //横屏请设置成 @"Landscape"
    //    NSString *launchImage = nil;
    //    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    //    for (NSDictionary* dict in imagesDict)
    //    {
    //        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
    //
    //        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
    //        {
    //            launchImage = dict[@"UILaunchImageName"];
    //        }
    //    }
    //    launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    //    launchView.backgroundColor = [UIColor redColor];
    //    launchView.frame = self.window.bounds;
    //    launchView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.window addSubview:launchView];
    //
    //    //    UIActivityIndicatorView *acView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //    //    [launchView addSubview:acView];
    //    //    [acView startAnimating];
    //    //    acView.hidesWhenStopped = YES;
    //    //    acView.center = launchView.center;
    //
    //    [UIView animateWithDuration:0.7f
    //        delay:0.0f
    //        options:UIViewAnimationOptionBeginFromCurrentState
    //        animations:^{
    //
    //        launchView.alpha = 0.0f;
    //        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
    //
    //        }
    //        completion:^(BOOL finished) {
    //        
    //        [launchView removeFromSuperview];
    //        
    //        }];
    //}


}

