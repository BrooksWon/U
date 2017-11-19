//
//  AppDelegate.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit
import AdSupport

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Bugtags 反馈
        let options = BugtagsOptions()
        options.enableUserSignIn = false
        Bugtags.start(withAppKey: "e5913a19c64342607c785784c7c340a7", invocationEvent: BTGInvocationEventNone, options: options)
        
        
        // idfa
        _ = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        // 版本更新
        (ATAppUpdater.sharedUpdater() as AnyObject).forceOpenNewAppVersion(true)
        
        //定制光标
        UITextField.appearance().tintColor = UIColor.white
        UITextView.appearance().tintColor = UIColor.white
        
        // UM push
        UMessage.start(withAppkey: "572a0d0fe0f55a9dc1001e9d", launchOptions: launchOptions)
        
        //register remoteNotification types
        let action1 = UIMutableUserNotificationAction.init()
        action1.identifier = "action1_identifier"
        action1.title = "action1_identifier"
        action1.activationMode = UIUserNotificationActivationMode.foreground//当点击的时候启动程序
        
        let action2 = UIMutableUserNotificationAction.init()
        action2.identifier = "action2_identifier"
        action2.title = "action2_identifier"
        action2.activationMode = UIUserNotificationActivationMode.background//当点击的时候不启动程序，在后台处理
        action2.isAuthenticationRequired = true//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.isDestructive = true
        
        let categorys = UIMutableUserNotificationCategory.init()
        categorys.identifier = "category1"//这组动作的唯一标示
        categorys.setActions([action1,action2], for: UIUserNotificationActionContext.default)
        
        let userSettings :UIUserNotificationSettings = UIUserNotificationSettings(types: [UIUserNotificationType.badge,UIUserNotificationType.alert,UIUserNotificationType.sound], categories: NSSet(object: categorys) as? Set<UIUserNotificationCategory>)
        
        UMessage.registerRemoteNotificationAndUserNotificationSettings(userSettings)        
        //UM 统计
        MobClick.setLogEnabled(false)
        MobClick.setCrashReportEnabled(false)
        MobClick.setAppVersion(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        MobClick.start(withAppkey: "572a0d0fe0f55a9dc1001e9d")
        
        //3Dtouch
        if #available(iOS 9.0, *) {
            let shortitem = UIApplicationShortcutItem.init(type: NSLocalizedString("VoiceKey", comment: ""), localizedTitle: NSLocalizedString("VoiceKey", comment: ""), localizedSubtitle: nil, icon: UIApplicationShortcutIcon.init(templateImageName: "nahan"), userInfo: nil)
            
            let shortItems = NSArray.init(object: shortitem)
            
            
            UIApplication.shared.shortcutItems = shortItems as? [UIApplicationShortcutItem]
        } else {
            // Fallback on earlier versions
        }
        
        if (launchOptions != nil) {
            if let notification = launchOptions![UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
                let msg:String = (notification as NSObject).value(forKeyPath: "aps.alert") as! String
                UserDefaults.standard.set(msg, forKey: "PUSH_MSG_KEY")
                UserDefaults.standard.synchronize()
            }
        }
        
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let rootNav = window?.rootViewController as! UINavigationController
        
        rootNav.show(MyVoiceViewController.init(), sender: nil)
        
        MobClick.event("3DTouch_btn")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UMessage.registerDeviceToken(deviceToken)
        MobClick.event("Register_success")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
        //如果注册成功，可以删掉这个方法
        MobClick.event("Register_Fail")

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //关闭友盟自带的弹出框
        UMessage.setAutoAlert(false)
        
        UMessage.didReceiveRemoteNotification(userInfo)
        
        showPushMsg(userInfo as NSObject)
        
        MobClick.event("didReceiveRemoteNotification")
    }
    
    func showPushMsg(_ userInfo: NSObject) {
        
        MobClick.event("showPushMsg")
        
        let msg:String = (userInfo as NSObject).value(forKeyPath: "aps.alert") as! String
        
        
        UserDefaults.standard.set(msg, forKey: "PUSH_MSG_KEY")
        UserDefaults.standard.synchronize()
        
        if !(msg.isEqual("")) {
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "HelveticaNeue", size: 1)!,
                kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
                kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
                showCloseButton: false
            )
            
            let alert = SCLAlertView(appearance: appearance)
            alert.addButton(NSLocalizedString("Push_Ok_Key", comment: "")) {
                let vc = (self.window?.rootViewController as! UINavigationController).viewControllers.last as! RootViewController
                vc.changeVoiceText()
                
                MobClick.event("dian_ji_hao_chan_kan_push")
                
            }
            alert.showNotice(NSLocalizedString("NotificationKey", comment: ""), subTitle: msg as String)
        }
    }
    
}

