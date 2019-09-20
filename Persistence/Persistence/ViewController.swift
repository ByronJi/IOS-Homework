//
//  ViewController.swift
//  Persistence
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lineFields : [UITextField]!
//    var dataDelegate : PersistenceDelegate = PlistManager.standard
    var dataDelegate : PersistenceDelegate = SQLiteManager.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var datas = dataDelegate.loadData()
        var i=0
        while(i < datas.count && i < lineFields.count) {
            lineFields[i].text = datas[i]
            i = i + 1
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    @objc func applicationWillResignActive(notification: Notification)
    {
        var datas : [String] = []
        for f in lineFields {
            datas.append(f.text ?? "")
        }
        dataDelegate.saveData(datas)
    }


}

