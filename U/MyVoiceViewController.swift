//
//  MyVoiceViewController.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class MyVoiceViewController: UIViewController {
    
    @IBOutlet weak var voiceTextView: DZMTextViewPlaceholder!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var commitBtn: UIButton!

    @IBAction func backBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SCLAlertView.tapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
        self.voiceTextView.placeholder = NSLocalizedString("YourWordsKey", comment: "")
        self.voiceTextView.placeholderColor = UIColor.whiteColor()
        self.nameTextField.placeholder = NSLocalizedString("WhoAreYouKey", comment: "")
        self.nameTextField.text = NSLocalizedString("WhoAreYouKey", comment: "")
        self.commitBtn.setTitle(NSLocalizedString("SayToTheWorldKey", comment: ""), forState: UIControlState.Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        MobClick.beginLogPageView(NSStringFromClass(self.classForCoder))
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        MobClick.endLogPageView(NSStringFromClass(self.classForCoder))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    @IBAction func commitBtnAction(sender: AnyObject) {
        self.view.endEditing(true)
        if (voiceTextView.text.compare(NSLocalizedString("YourWordsKey", comment: "")) == NSComparisonResult.OrderedSame) || (nameTextField.text!.compare(NSLocalizedString("WhoAreYouKey", comment: "")) == NSComparisonResult.OrderedSame) || voiceTextView.text.isEmpty || nameTextField.text!.isEmpty {
            MobClick.event("tiaojiaoEmpty_btn")
            return
        }
        
        showSuccess(sender)
        
        // 利用UM反馈作为数据提交的api
        let stringContent:String = NSString.init(format: "%@ by%@", voiceTextView.text, nameTextField.text!) as String
        let pDic:Dictionary<String,String> = ["content":stringContent];
        UMFeedback.sharedInstance().post(pDic) { (error) in
            if (error != nil) {
                NSLog("error ====== %@", error)
                 MobClick.event("tiaojiaoError")
            }else {
                MobClick.event("tiaojiaoSuccess")
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
        alert.addButton(NSLocalizedString("ShouDao_Done_Key", comment: "")) {
            self.navigationController?.popViewControllerAnimated(true)
            self.view.viewWithTag(10086)?.removeFromSuperview()
            MobClick.event("tiaojiaoHao_btn")
        }
        alert.addButton(NSLocalizedString("ShouDao_Again_Key", comment: "")) {
            MobClick.event("tiaojiaoAgin_btn")
            self.view.viewWithTag(10086)?.removeFromSuperview()
        }
        alert.showSuccess(NSLocalizedString("ShouDaoKey", comment: ""), subTitle: "")
    }
    
    func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
        MobClick.event("shou_qi_jian_pan_shou_shi")
    }

}
