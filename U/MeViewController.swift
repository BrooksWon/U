//
//  MeViewController.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var lineLabel: UILabel!
    
    var voiceText:String!
    
    var llSwitch: LLSwitch!
    func setupLLSwitch() -> LLSwitch {
        if nil == llSwitch {
            llSwitch = LLSwitch.init(frame:CGRectMake(0, 0, 60, 30))
        }
        llSwitch.delegate = self
        return llSwitch
    }

    
    @IBAction func backBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    let items = ["是否接收push消息", "给个好评👌", "分享", "攻略"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        versionLabel.text = (NSString(format: "当前版本 %@", version)) as String
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension MeViewController: UITableViewDelegate {
}

extension MeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        if (0 == indexPath.row) {
            let cellID1 = "cellID1"
            cell = tableView.dequeueReusableCellWithIdentifier(cellID1)
            if (nil == cell) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID1)
                cell?.accessoryType = UITableViewCellAccessoryType.None
                cell?.textLabel?.textColor = UIColor.whiteColor()
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                
                cell?.backgroundColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
                for subView in (cell?.subviews)! {
                    (subView as UIView).backgroundColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
                }
                
                cell?.addSubview(self.setupLLSwitch())
                llSwitch.frame = CGRectMake(cell!.frame.size.width-60-5, (cell!.frame.size.height-30)/2.0, 60, 30)
            }
            
            
            cell!.textLabel?.text = items[indexPath.row]
            
            llSwitch.on = isPushturnOn()
        }else {
            let cellID2 = "cellID2"
            cell = tableView.dequeueReusableCellWithIdentifier(cellID2)
            if (nil == cell) {
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID2)
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell?.textLabel?.textColor = UIColor.whiteColor()
                cell?.selectionStyle = UITableViewCellSelectionStyle.Gray
                
                cell?.backgroundColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
                for subView in (cell?.subviews)! {
                    (subView as UIView).backgroundColor = UIColor.init(red: 27/255.0, green: 27/255.0, blue: 28/255.0, alpha: 1.0)
                }
            }
            
            
            cell!.textLabel?.text = items[indexPath.row]
        }
        
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            break;
        case 1:
            //评分
            UIApplication.sharedApplication().openURL(NSURL.init(string: "https://itunes.apple.com/us/app/u./id1110613814?l=zh&ls=1&mt=8")!)
            break;
        case 2:
            //分享
            self.showNotice()
            break;
        case 3:
            //攻略
            break;
        default: break
        }
    }
    
    func showNotice() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: true
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
    
    func share2WeChat(sceneType:Int32) -> Bool {
        let ext = WXWebpageObject()
        ext.webpageUrl = "https://itunes.apple.com/us/app/u./id1110613814?l=zh&ls=1&mt=8"
        
        let message = WXMediaMessage()
        if sceneType == 0 {
            message.title = "悦己未必悅人，为自己发声！"
        }else {
            message.title = self.voiceText
        }
        
        message.description = self.voiceText
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
    
    
    func isPushturnOn() -> Bool {
        let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
        if(UIUserNotificationType.None == setting!.types) {
            return true
        }
        return false
    }
    
}

extension MeViewController: LLSwitchDelegate {
    func didTapLLSwitch(llSwitch:LLSwitch) {
        //
    }
    func animationDidStopForLLSwitch(llSwitch:LLSwitch) {
        if llSwitch.on {
            let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
            if(UIUserNotificationType.None == setting!.types) {
                let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
                if UIApplication.sharedApplication().canOpenURL(url!) {
                    UIApplication.sharedApplication().openURL(url!)
                }
            }
        }
    }
}
