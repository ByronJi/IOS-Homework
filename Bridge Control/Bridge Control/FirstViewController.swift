//
//  FirstViewController.swift
//  Bridge Control
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var officerLabel: UILabel!
    
    @IBOutlet weak var authorizationCodeLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var warpDriveLabel: UILabel!
    
    @IBOutlet weak var warpFactorLabel: UILabel!
    
    @IBOutlet weak var favoriteTeaLabel: UILabel!
    
    @IBOutlet weak var favoriteCaptianLabel: UILabel!
    
    @IBOutlet weak var favoriteGadgetLabel: UILabel!
    
    @IBOutlet weak var favoriteAlienLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func refreshField(){
        let defaults = UserDefaults.standard
        officerLabel.text = defaults.string(forKey: officerKey)
        authorizationCodeLabel.text = defaults.string(forKey: authorizationCodeKey)
        rankLabel.text = defaults.string(forKey: rankKey)
        warpDriveLabel.text = defaults.bool(forKey: warpDriveKey) ? "Engaged" : "Disabled"
        warpFactorLabel.text = (defaults.object(forKey: warpFactorKey) as AnyObject).stringValue
        favoriteTeaLabel.text = defaults.string(forKey: favoriteTeaKey)
        favoriteCaptianLabel.text = defaults.string(forKey: favoriteCaptainKey)
        favoriteGadgetLabel.text = defaults.string(forKey: favoriteGadgetKey)
        favoriteAlienLabel.text = defaults.string(forKey: favoriteAlienKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshField()
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillEnterForeground(notification:)), name: UIApplication.willEnterForegroundNotification, object: app)
    }
    
    @objc func applicationWillEnterForeground(notification:NSNotification){
        let defaults = UserDefaults.standard
        defaults.synchronize()
        refreshField()
    }
    
}

