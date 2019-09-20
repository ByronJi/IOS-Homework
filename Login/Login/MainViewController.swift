//
//  MainViewController.swift
//  login
//
//  Created by Byron on 2019/5/8.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userinfo = AppArchiver.share.read()
        userName.text = userinfo?.userName
        // Do any additional setup after loading the view.
    }
    
    
}
