//
//  DZMTextViewPlaceholder.swift
//  DZMTextViewPlaceholder
//
//  Created by haspay on 16/3/16.
//  Copyright © 2016年 DZM. All rights reserved.
//

import UIKit

class DZMTextViewPlaceholder: UITextView {
    
    /// placeholder
    var placeholder:String?{
        didSet{
            if placeholderLabel != nil {
                placeholderLabel.text = placeholder
                setNeedsLayout()
            }
        }
    }
    
    /// placeholderColor
    var placeholderColor:UIColor! = UIColor.lightGrayColor() {
        didSet{
            if placeholderLabel != nil {
                placeholderLabel.textColor = placeholderColor
            }
        }
    }
    
    /// placeholderFont
    var placeholderFont:UIFont! = UIFont.systemFontOfSize(14) {
        didSet{
            if placeholderLabel != nil {
                placeholderLabel.font = placeholderFont
                setNeedsLayout()
            }
        }
    }
    
    private var placeholderLabel:UILabel!
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        addNotificationCenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addNotificationCenter()
    }
    
    
    func addNotificationCenter() {
        
        placeholderLabel = UILabel()
        placeholderLabel.backgroundColor = UIColor.clearColor()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = placeholderFont
        addSubview(placeholderLabel)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DZMTextViewPlaceholder.textDidChange), name: UITextViewTextDidChangeNotification, object: self)
    }
    
    deinit {
        
        debugPrint("DZMTextViewPlaceholder 释放了")
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if placeholder != nil {
            
            let spaceX:CGFloat = 6

            let maxW = frame.size.width - textContainerInset.left - textContainerInset.right - spaceX
            let maxH = frame.size.height - textContainerInset.top - textContainerInset.bottom
            
            let placeholderLabelSize = (placeholder! as NSString).boundingRectWithSize(CGSizeMake(maxW,maxH), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: placeholderFont!], context: nil)
            
            placeholderLabel.frame = CGRectMake(textContainerInset.left + spaceX, textContainerInset.top, placeholderLabelSize.width, placeholderLabelSize.height)
        }
    }
    
    
    // 文本输入监听  如果是插入 attributedText  则需要在插入的地方调用该方法进行监听 比如输入框自定义做的表情插入
    func textDidChange() {
        
        if placeholder != nil && text.isEmpty {
            placeholderLabel.hidden = false
        }else{
            placeholderLabel.hidden = true
        }
    }
}
