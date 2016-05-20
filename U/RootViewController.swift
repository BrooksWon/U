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
    @IBOutlet var byUerLabel: UILabel!
    @IBOutlet weak var navBar: UIView!
    
//    var voiceEffectLabel: LTMorphingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        If white background
//        glitchLabel.blendMode = .Multiply
        glitchLabel.text = "Hello, Uer!"
//        view.backgroundColor = UIColor.whiteColor()
        
//        let seg = sender
//        if let effect = LTMorphingEffect(rawValue: 1) {
//            self.voiceLabel.morphingEffect = effect
//            self.voiceLabel.numberOfLines = 0
//        }
        
        sleep(1);
        
        UIView.animateWithDuration(3.0, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
            self.glitchLabel.alpha = 0.0
            self.glitchLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
            
        }) { (finished) in
            self.glitchLabel.removeFromSuperview()
            // path
            self.view.addSubview(self.addPathMenu())
            self.voiceLabel.hidden = false
            self.byUerLabel.hidden = false
            self.navBar.hidden = false
            
            self.changeVoiceText()
        }
    }

    
    func changeVoiceText() {
        if ((NSUserDefaults.standardUserDefaults().objectForKey("PUSH_MSG_KEY")) != nil){
            let content = (NSUserDefaults.standardUserDefaults().objectForKey("PUSH_MSG_KEY")) as! NSString as String
            let voice = (content.componentsSeparatedByString("by") as NSArray).firstObject as! NSString
            let uer = (content.componentsSeparatedByString("by") as NSArray).lastObject as! NSString
            
            self.voiceLabel.text = voice as String
            self.byUerLabel.text = NSString.init(format: "by %@", uer) as String
        }else {
            self.voiceLabel.text = "在以后的日子里，愿你被世界温柔以待。"
            self.byUerLabel.text = "by 倪小暖"
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
        
        
        let starMenuItem1 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "info")!)
        let starMenuItem2 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "ktv")!)
        let starMenuItem3 = PathMenuItem.init(image: UIImage(named: "plusBg")!, highlightedImage: UIImage(named: "plusBg")!, contentImage: UIImage(named: "jvbao")!)
        
        let items = [starMenuItem1, starMenuItem2, starMenuItem3]
        let count = 3.0
        
        
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
            //更多
            let vc = MeViewController.init()
            vc.voiceText = self.voiceLabel.text;
            self.showViewController(vc, sender: nil)
            break
        case 1:
            // 我的Voice
            self.showViewController(MyVoiceViewController.init(), sender: nil)
            break
        case 2:
            //举报
            showJvBao()
            break;
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
    
    func showJvBao() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton("举报") {
            SCLAlertView().showSuccess("举报成功", subTitle: "")
        }
        alert.addButton("点错了") {
            //
        }
        alert.showWarning("举报该内容和用户", subTitle: "")
    }
}


