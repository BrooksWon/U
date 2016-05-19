//
//  MyVoiceViewController.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit


let kSuccessTitle = "U. 已收到您的呐喊"
let kErrorTitle = "世界已崩溃！"
let kNoticeTitle = "提示"
let kWarningTitle = "警告"
let kInfoTitle = "提示"
let kSubtitle = "再呐喊一次 ？"

let kVoice = "你的呐喊..."
let kName = "你是谁"



class MyVoiceViewController: UIViewController {
    
    @IBOutlet weak var voiceTextView: DZMTextViewPlaceholder!
    @IBOutlet weak var nameTextField: UITextField!

    @IBAction func backBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SCLAlertView.tapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        self.voiceTextView.placeholder = "你的呐喊..."
        self.voiceTextView.placeholderColor = UIColor.whiteColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    @IBAction func commitBtnAction(sender: AnyObject) {
        self.view.endEditing(true)
        if (voiceTextView.text.compare(kVoice) == NSComparisonResult.OrderedSame) || (nameTextField.text!.compare(kName) == NSComparisonResult.OrderedSame) || voiceTextView.text.isEmpty || nameTextField.text!.isEmpty {
            return
        }
        
        showSuccess(sender)
        
        // 利用UM反馈作为数据提交的api
        let stringContent:String = NSString.init(format: "%@ by%@", voiceTextView.text, nameTextField.text!) as String
        let pDic:Dictionary<String,String> = ["content":stringContent];
        UMFeedback.sharedInstance().post(pDic) { (error) in
            if (error != nil) {
                NSLog("error ====== %@", error)
            }
        }
        
        // 毛玻璃
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
        visualEffectView.frame = view.bounds
        visualEffectView.tag = 10086
        view.addSubview(visualEffectView)
    }
    

    @IBAction func showSuccess(sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("好") {
            self.navigationController?.popViewControllerAnimated(true)
            self.view.viewWithTag(10086)?.removeFromSuperview()
        }
        alert.addButton("再来一次") {
            print("Second button tapped")
            self.view.viewWithTag(10086)?.removeFromSuperview()
        }
        alert.showSuccess(kSuccessTitle, subTitle: "")
    }
    
    @IBAction func showError(sender: AnyObject) {
//        SCLAlertView().showError(kErrorTitle, subTitle:"You have not saved your Submission yet. Please save the Submission before accessing the Responses list. Blah de blah de blah, blah. Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.Blah de blah de blah, blah.", closeButtonTitle:"OK")
//                SCLAlertView().showError(self, title: kErrorTitle, subTitle: kSubtitle)
        let alert = SCLAlertView()
//        alert.addButton("再来一次") {
//            print("Second button tapped")
//        }
        alert.showError(kErrorTitle, subTitle: "")
    }
    
    @IBAction func showNotice(sender: AnyObject) {
        SCLAlertView().showNotice(kNoticeTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showWarning(sender: AnyObject) {
        SCLAlertView().showWarning(kWarningTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showInfo(sender: AnyObject) {
        SCLAlertView().showInfo(kInfoTitle, subTitle: kSubtitle)
    }
    
    @IBAction func showEdit(sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: true)
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("Enter your name")
        alert.addButton("Show Name") {
            print("Text value: \(txt.text)")
        }
        alert.showEdit(kInfoTitle, subTitle:kSubtitle)
    }
    
    
    @IBAction func showCustomSubview(sender: AnyObject) {
        // Create custom Appearance Configuration
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        
        // Initialize SCLAlertView using custom Appearance
        let alert = SCLAlertView(appearance: appearance)
        
        // Creat the subview
        let subview = UIView(frame: CGRectMake(0,0,216,70))
        let x = (subview.frame.width - 180) / 2
        
        // Add textfield 1
        let textfield1 = UITextField(frame: CGRectMake(x,10,180,25))
        textfield1.layer.borderColor = UIColor.greenColor().CGColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield1)
        
        // Add textfield 2
        let textfield2 = UITextField(frame: CGRectMake(x,textfield1.frame.maxY + 10,180,25))
        textfield2.secureTextEntry = true
        textfield2.layer.borderColor = UIColor.blueColor().CGColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield1.layer.borderColor = UIColor.blueColor().CGColor
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        alert.addButton("Login") {
            print("Logged in")
        }
        
        // Add Button with Duration Status and custom Colors
        alert.addButton("Duration Button", backgroundColor: UIColor.brownColor(), textColor: UIColor.yellowColor(), showDurationStatus: true) {
            print("Duration Button tapped")
        }
        
        alert.showInfo("Login", subTitle: "", duration: 10)
    }
    
    
    func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}
