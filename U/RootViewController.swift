//
//  RootViewController.swift
//  U
//
//  Created by Brooks on 16/5/4.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var glitchLabel: GlitchLabel!
    @IBOutlet weak var voiceLabel: UILabel!
    @IBOutlet weak var byUerLabel: LTMorphingLabel!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var navBarTittleLabel: LTMorphingLabel!
    
    @IBOutlet weak var zanLabel: UILabel!
    
    var emojiFlay : LSEmojiFly!
    
    
    let keys = ["生日", "爱", "生活", "gay", "你算什么", "傻逼", "牛逼"]
    let kekDic = ["生日":"shengri", "爱":"lover", "生活" :"life", "gay":"gay", "你算什么":"nssm", "傻逼" :"sb", "牛逼":"nb",]
    
    
    //点赞动画
    fileprivate struct HeartAttributes {
        static let heartSize: CGFloat = 36
        static let burstDelay: TimeInterval = 0.1
    }
    var burstTimer: Timer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        If white background
//        glitchLabel.blendMode = .Multiply
        glitchLabel.text = "Hello, Uer!"
//        view.backgroundColor = UIColor.whiteColor()
        
        sleep(1);
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
            self.glitchLabel.alpha = 0.0
            self.glitchLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
            
        }) { (finished) in
            
            // 打开状态栏
            UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
            
            self.glitchLabel.removeFromSuperview()
            // path
            self.view.addSubview(self.addPathMenu())
            self.voiceLabel.isHidden = false
            self.byUerLabel.isHidden = false
            self.zanLabel?.isHidden = false
            self.navBar.isHidden = false
            
            if let effect = LTMorphingEffect(rawValue: 4) {
                self.navBarTittleLabel.morphingEffect = effect
            }
            
            self.navBarTittleLabel.text = "U."
            
            self.changeVoiceText()
        }
        
        
        // 右滑点赞
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeGestureLeft)
        
        // 旋转点大赞，右滑，每次点赞10次
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureAction))
        view.addGestureRecognizer(rotationGesture)
        
//        //单击点赞
//        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(showTheLove))
//        view.addGestureRecognizer(tapGesture1)
//        
//        //长按点赞
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureAction))
//        longPressGesture.minimumPressDuration = 0.2
//        view.addGestureRecognizer(longPressGesture)
    }
    
    func longPressGestureAction(_ longPressGesture: UILongPressGestureRecognizer) {
        switch longPressGesture.state {
        case .began:
            burstTimer = Timer.scheduledTimer(timeInterval: HeartAttributes.burstDelay, target: self, selector: #selector(showTheLove), userInfo: nil, repeats: true)
        case .ended, .cancelled:
            burstTimer?.invalidate()
        default:
            break
        }
    }
    
    
    func swipeGestureAction(_ swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.direction == UISwipeGestureRecognizerDirection.right {
            showTheLove()
        }
    }
    
    func rotationGestureAction(_ rotationGesture: UIRotationGestureRecognizer) {
        switch rotationGesture.state {
        case UIGestureRecognizerState.began:
            burstTimer = Timer.scheduledTimer(timeInterval: HeartAttributes.burstDelay, target: self, selector: #selector(showTheLove), userInfo: nil, repeats: true)
            break
        case UIGestureRecognizerState.ended:
            burstTimer?.invalidate()
            NSLog("1")
            break
        default:
            break
        }
    }
    
    func showTheLove() {
        let heart = HeartView(frame: CGRect(x: 0, y: 0, width: HeartAttributes.heartSize, height: HeartAttributes.heartSize))
        self.view.addSubview(heart)
        let fountainX = HeartAttributes.heartSize / 2.0 + 20
        let fountainY = view.bounds.height - HeartAttributes.heartSize / 2.0 - 10
        heart.center = CGPoint(x: fountainX, y: fountainY)
        heart.animateInView(self.view)
        
        //更改点赞的数目
        let like = self.zanLabel?.text?.substring(from: (self.zanLabel?.text?.characters.index((self.zanLabel?.text?.startIndex)!, offsetBy: 1))!)
        self.zanLabel?.text = NSString(format: "👍%d", Int(like!)!+1) as String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MobClick.beginLogPageView(NSStringFromClass(self.classForCoder))
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        MobClick.endLogPageView(NSStringFromClass(self.classForCoder))
    }
    
    func changeVoiceText() {
        MobClick.event("voiceText_change")
        
        let index = Int(arc4random_uniform(7))
        if let effect = LTMorphingEffect(rawValue: index) {
            self.byUerLabel.morphingEffect = effect
        }
        
        if ((UserDefaults.standard.object(forKey: "PUSH_MSG_KEY")) != nil){
            let content = (UserDefaults.standard.object(forKey: "PUSH_MSG_KEY")) as! NSString as String
            let voice = (content.components(separatedBy: "by") as NSArray).firstObject as! NSString
            let uer = (content.components(separatedBy: "by") as NSArray).lastObject as! NSString
            
            self.voiceLabel.text = voice as String
            self.byUerLabel.text = NSString.init(format: "by %@", uer) as String
            self.zanLabel?.text = "👍1"
        
            self.perform(#selector(rainFly), with: nil, afterDelay: 1.0)
            
        }else {
            self.voiceLabel.text = NSLocalizedString("DefaultVoiceKey", comment: "wobuzhidao")
            self.byUerLabel.text = NSString.init(format: "by %@", NSLocalizedString("ByUerKey", comment: "None")) as String
            self.zanLabel?.text = "👍1"
        }
    }
    
    func rainFly() {
        var key : String!
        for item in keys {
            if ((self.voiceLabel.text?.contains(item)) == true) {
                key = item
                break
            }
        }
        
        if nil != key {
            self.emojiFlay = LSEmojiFly()
            self.emojiFlay.start(withEmojiImage: UIImage.init(named: kekDic[key]!), on: self.view)
            
            self.emojiFlay.perform(#selector(LSEmojiFly.end), with: nil, afterDelay: 3.0)
        }
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
        menu.startPoint     = CGPoint(x: UIScreen.main.bounds.width/2, y: view.frame.size.height - 30.0)
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
    public func didSelect(on menu: PathMenu, index: Int) {
        switch index {
        case 0:
            MobClick.event("gengduo_btn")
            //更多
            let vc = MeViewController.init()
            vc.voiceText = self.voiceLabel.text;
            self.show(vc, sender: nil)
            break
        case 1:
            MobClick.event("voice_btn")
            // 我的Voice
            self.navigationController?.pushViewController(MyVoiceViewController.init(), animated: true)
            break
        case 2:
            MobClick.event("jvbao_btn")
            //举报
            showJvBao()
            break;
        default:
            break;
        }
    }
    public func willStartAnimationOpen(on menu: PathMenu) {
        //
    }
    public func willStartAnimationClose(on menu: PathMenu) {
        //
    }
    public func didFinishAnimationOpen(on menu: PathMenu) {
        //
    }
    public func didFinishAnimationClose(on menu: PathMenu) {
        //
    }
    func showJvBao() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)

        alert.addButton(NSLocalizedString("JvBao_Yes_Key", comment: "")) {
            SCLAlertView().showSuccess(NSLocalizedString("JvBao_Success_Key", comment: ""), subTitle: "")
            MobClick.event("jvbaoSuccess_btn")
        }
        alert.addButton(NSLocalizedString("JvBao_NO_Key", comment: "")) {
            MobClick.event("jvbaoError_btn")
        }
        alert.showWarning(NSLocalizedString("JvBaoKey", comment: ""), subTitle: "")
    }
}


