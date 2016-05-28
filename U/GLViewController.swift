//
//  GLViewController.swift
//  U
//
//  Created by Brooks on 16/5/22.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class GLViewController: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBAction func backBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.noteTextView.text = NSLocalizedString("NoteTextKey", comment: "")
        self.noteTextView.textColor = UIColor.whiteColor()
        self.noteTextView.font = UIFont.systemFontOfSize(14.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
