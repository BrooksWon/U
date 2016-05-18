//
//  RootViewController.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var glitchLabel: GlitchLabel!
    @IBOutlet var voiceLabel: UILabel!
    @IBOutlet weak var navBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        If white background
//        glitchLabel.blendMode = .Multiply
        glitchLabel.text = "Hello, Uer!"
//        view.backgroundColor = UIColor.whiteColor()
       
        
        sleep(1);
        
        UIView.animateWithDuration(3.0, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            self.glitchLabel.alpha = 0.0
            self.glitchLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
            
        }) { (finished) in
            self.glitchLabel.removeFromSuperview()
            // path
            self.view.addSubview(self.addPathMenu())
            self.voiceLabel.hidden = false
            self.navBar.hidden = false
            self.voiceLabel.text = "在以后的日子里，愿你被世界温柔以待。\n \n                                                   by 倪小暖"
            if ((NSUserDefaults.standardUserDefaults().objectForKey("PUSH_MSG_KEY")) != nil){
                self.voiceLabel.text = (NSUserDefaults.standardUserDefaults().objectForKey("PUSH_MSG_KEY")) as! NSString as String
            }
            
        }
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPathMenu() -> PathMenu {
        
        let starMenuItem1 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "comment")!)
        
        let starMenuItem2 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "ktv")!)
        
        let starMenuItem3 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "info")!)
        
        let starMenuItem4 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "share")!)
        
        let starMenuItem5 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "jvbao")!)
        
        var items = [starMenuItem1, starMenuItem2, starMenuItem3,starMenuItem5]
        var count = 4.0
//        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupportApi() {
            items = [starMenuItem1, starMenuItem2, starMenuItem4, starMenuItem3, starMenuItem5]
            count = 5.0
//        }
        
        
        
        
//        starMenuItem2.endPoint = CGPointMake(300, view.frame.size.height - 230.0)
        
//        let items = [starMenuItem1, starMenuItem2, starMenuItem3]
        
        let startItem = PathMenuItem.init(image: UIImage(named: "plusBg")!,
                                          highlightedImage: UIImage(named: "plusBg"),
                                          contentImage: UIImage(named: "plus"),
                                          highlightedContentImage: UIImage(named: "plus"))
        
        
        let menu = PathMenu.init(frame: view.bounds, startItem: startItem, items: items)
        menu.delegate = self
        menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width/2, view.frame.size.height - 30.0)
        menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/count)
        menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/count) * 1/2
        menu.timeOffset     = 0.0
        menu.farRadius      = 110.0
        menu.nearRadius     = 90.0
        menu.endRadius      = 100.0
        menu.animationDuration = 0.5
        
        return menu
    }
    
}

extension RootViewController: PathMenuDelegate {
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        print("Select the index : \(idx)")
        switch idx {
        case 0:
            //评分
            UIApplication.sharedApplication().openURL(NSURL.init(string: "https://itunes.apple.com/us/app/u./id1110613814?l=zh&ls=1&mt=8")!)
            break
        case 1:
            // 我的Voice
            self.showViewController(MyVoiceViewController.init(), sender: nil)
            break
        case 2:
            //分享
            showNotice()
            break;
        case 3:
            //关于
            self.showViewController(MeViewController.init(), sender: nil)
            break
        case 4:
            //举报
            showJvBao()
            break
        default:
            break;
        }
    }
    
    func pathMenuWillAnimateOpen(menu: PathMenu) {
        print("Menu will open!")
    }
    
    func pathMenuWillAnimateClose(menu: PathMenu) {
        print("Menu will close!")
    }
    
    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
        print("Menu was open!")
    }
    
    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
        print("Menu was closed!")
    }
    
    func share2WeChat(sceneType:Int32) -> Bool {
        let ext = WXWebpageObject()
        ext.webpageUrl = "https://itunes.apple.com/us/app/u./id1110613814?l=zh&ls=1&mt=8"
        
        let message = WXMediaMessage()
        if sceneType == 0 {
             message.title = "悦己未必悅人，为自己发声！"
        }else {
            message.title = self.voiceLabel.text
        }
        
        message.description = self.voiceLabel.text
        message.mediaObject = ext
        message.setThumbImage(UIImage.init(named: "Icon1024x1024"))
        
        let req = SendMessageToWXReq.init()
        req.message = message
        req.scene = sceneType;
        
        /*
         
         /*! @brief 请求发送场景
         *
         */
         enum WXScene {
         WXSceneSession  = 0,        /**< 聊天界面    */
         WXSceneTimeline = 1,        /**< 朋友圈      */
         WXSceneFavorite = 2,        /**< 收藏       */
         };
         
         */
        
        return WXApi.sendReq(req)
    }
    
    func showNotice() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("朋友圈") {
            self.share2WeChat(1)
        }
        alert.addButton("微信好友") {
             self.share2WeChat(0)
        }
        alert.showNotice("分享到", subTitle: "")
    }
    
    func showJvBao() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("点错了") {
            //
        }
        alert.addButton("举报") {
            SCLAlertView().showSuccess("举报成功", subTitle: "")
        }
        alert.showWarning("举报该内容和用户", subTitle: "")
    }
}


