//
//  SecondViewController.swift
//  Bridge Control
//
//  Created by Byron on 2019/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var engineSwitch: UISwitch!
    
    @IBOutlet weak var warpFactorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshFields()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func refreshFields(){
        let defaults = UserDefaults.standard
        engineSwitch.isOn = defaults.bool(forKey: warpDriveKey)
        warpFactorSlider.value = defaults.float(forKey: warpFactorKey)
    }
    
    @IBAction func onEngineSwitchTapped(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        defaults.set(engineSwitch.isOn, forKey: warpDriveKey)
        defaults.synchronize()
    }
    
    
    @IBAction func onWarpSliderDragged(_ sender: UISlider) {
        let defaults = UserDefaults.standard
        defaults.set(warpFactorSlider.value, forKey: warpFactorKey)
        defaults.synchronize()
    }
    
    func applicationWillEnterForeground(notification:NSNotification){
        let defaults = UserDefaults.standard
        defaults.synchronize()
        refreshFields()
    }
    
    
    @IBAction func onSettingsButtonTapped(_ sender: UIButton) {
        let application = UIApplication.shared
        let url = URL(string:UIApplication.openSettingsURLString)! as URL
        if application.canOpenURL(url){
            application.open(url, options:[UIApplication.OpenExternalURLOptionsKey(rawValue: ""):""], completionHandler: nil)
        }
    }
    
}

