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
            self.view.backgroundColor = UIColor.whiteColor()
            // path
            self.view.addSubview(self.addPathMenu())
            UIApplication.sharedApplication().statusBarHidden = false
            self.voiceLabel.hidden = false
            self.voiceLabel.text = "愿我在以后的日子里，你能被世界温柔以待。\n \n by 暖小团"
            
        }
        
        
        
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPathMenu() -> PathMenu {
        let menuItemImage = UIImage.init(named: "bg-menuitem-highlighted")
        let menuItemHighlitedImage = UIImage.init(named: "bg-menuitem-highlighted")
        let starImage = UIImage.init(named: "icon-star")
        
        let starMenuItem1 = PathMenuItem.init(image: menuItemImage!, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem2 = PathMenuItem.init(image: menuItemImage!, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem3 = PathMenuItem.init(image: menuItemImage!, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        
        starMenuItem2.endPoint = CGPointMake(300, view.frame.size.height - 230.0)
        
        let items = [starMenuItem1, starMenuItem2, starMenuItem3]
        
        let startItem = PathMenuItem.init(image: UIImage(named: "bg-addbutton")!,
                                          highlightedImage: UIImage(named: "bg-addbutton-highlighted"),
                                          contentImage: UIImage(named: "icon-plus"),
                                          highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
        
        
        let menu = PathMenu.init(frame: view.bounds, startItem: startItem, items: items)
        menu.delegate = self
        menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width/2, view.frame.size.height - 30.0)
        menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/3)
        menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/3) * 1/2
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
            //关于
            self.showViewController(MeViewController.init(), sender: nil)
            break
        case 2:
            // 我的Voice
            self.showViewController(MyVoiceViewController.init(), sender: nil)
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
}


