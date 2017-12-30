//
//  NotificationController.m
//  iWatch Extension
//
//  Created by Brooks on 2017/12/31.
//  Copyright © 2017年 王建雨. All rights reserved.
//

#import "NotificationController.h"
#import <UserNotifications/UserNotifications.h>


@interface NotificationController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *pushMessageLabel;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
//    completionHandler(WKUserNotificationInterfaceTypeCustom);
    
    //取出自定义的通知的内容并展示到界面的各个组件上
    UNNotificationContent *content = notification.request.content;
//    NSDictionary *customDic = [content.userInfo objectForKey:@"customKey"];
    [self.pushMessageLabel setText:@"新的push 内容"];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
    
    /*
     
     NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
     [userInfo setObject:@"say something" forKey:@"openType"];
     [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error){
     
     //主应用处理完后的回调，返回extension所需的数据
     NSString *words = [replyInfo objectForKey:@"words"];
     NSLog(@"say: %@",words);
     }];
     
     **/
}

@end



