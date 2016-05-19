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
    
    let items = ["是否接收push消息"]
    
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
        
        let cellID2 = "cellID2"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID2)
        if (nil == cell) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID2)
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
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
