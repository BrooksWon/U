//
//  GLViewController.swift
//  U
//
//  Created by Brooks on 16/5/22.
//  Copyright © 2016年 王建雨. All rights reserved.
//

import UIKit

class GLViewController: UIViewController {
    
    @IBAction func backBtnAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
