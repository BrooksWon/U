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
        
        // 版本更新
        ATAppUpdater.sharedUpdater().forceOpenNewAppVersion(true)
        
        //定制光标
        UITextField.appearance().tintColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
        UITextView.appearance().tintColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
        //下一版本最好增加3Dtouch
        
        // UM push
        UMessage.startWithAppkey("572a0d0fe0f55a9dc1001e9d", launchOptions: launchOptions)
        
        //register remoteNotification types
        let action1 = UIMutableUserNotificationAction.init()
        action1.identifier = "action1_identifier"
        action1.title = "action1_identifier"
        action1.activationMode = UIUserNotificationActivationMode.Foreground//当点击的时候启动程序
        
        let action2 = UIMutableUserNotificationAction.init()
        action2.identifier = "action1_identifier"
        action2.title = "action1_identifier"
        action2.activationMode = UIUserNotificationActivationMode.Background//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = true//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = true
        
        let categorys = UIMutableUserNotificationCategory.init()
        categorys.identifier = "category1"//这组动作的唯一标示
        categorys.setActions([action1,action2], forContext: UIUserNotificationActionContext.Default)
        
        let userSettings :UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Badge,UIUserNotificationType.Alert,UIUserNotificationType.Sound], categories: NSSet(object: categorys) as? Set<UIUserNotificationCategory>)
        
        UMessage.registerRemoteNotificationAndUserNotificationSettings(userSettings)
        UMessage.setLogEnabled(true)
        
        //UM 统计
        MobClick.setLogEnabled(true)
        MobClick.setAppVersion(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String)
        MobClick.startWithAppkey("572a0d0fe0f55a9dc1001e9d")
        
        //3Dtouch
        if #available(iOS 9.0, *) {
            let shortitem = UIApplicationShortcutItem.init(type: "呐喊", localizedTitle: "呐喊", localizedSubtitle: nil, icon: UIApplicationShortcutIcon.init(templateImageName: "nahan"), userInfo: nil)
            
            let shortItems = NSArray.init(object: shortitem)
            
            
            UIApplication.sharedApplication().shortcutItems = shortItems as? [UIApplicationShortcutItem]
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let rootNav = window?.rootViewController as! UINavigationController
        
        rootNav.showViewController(MyVoiceViewController.init(), sender: nil)
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
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        UMessage.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
        //如果注册成功，可以删掉这个方法
        NSLog("application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //关闭友盟自带的弹出框
        UMessage.setAutoAlert(true)
        
        UMessage.didReceiveRemoteNotification(userInfo)
        
        let pushMsgDic = NSDictionary.init(dictionary: userInfo)
        let apsDic = NSDictionary.init(dictionary: pushMsgDic.objectForKey("aps") as! NSObject as! [NSDictionary : AnyObject])
        let msg = apsDic.objectForKey("alert")
        
        
        NSUserDefaults.standardUserDefaults().setObject(msg, forKey: "PUSH_MSG_KEY")
        NSUserDefaults.standardUserDefaults().synchronize()

        if msg != nil && !(msg?.isEqual(""))! {
            showPushMsg(msg as! NSString)
        }
    }
    
    func showPushMsg(msg: NSString) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 1)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        
        alert.showNotice(kNoticeTitle, subTitle: msg as String)
    }
}

