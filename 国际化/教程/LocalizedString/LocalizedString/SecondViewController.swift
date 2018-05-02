//
//  SecondViewController.swift
//  LocalizedString
//
//  Created by tlc on 2018/5/2.
//  Copyright © 2018年 tlc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 隐藏push视图返回按钮文字为空
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: nil, style: .done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

