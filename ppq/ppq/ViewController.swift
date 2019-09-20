//
//  ViewController.swift
//  ppq
//
//  Created by Byron on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    
    var oldFrame:CGRect!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        oldFrame = imageView.frame
    }

    @IBAction func tap(_ sender:UITapGestureRecognizer){
        if imageView.frame.size.width < view.frame.size.width{
            imageView.frame = view.frame
        } else{
            imageView.frame = oldFrame
        }
        
    }
}

