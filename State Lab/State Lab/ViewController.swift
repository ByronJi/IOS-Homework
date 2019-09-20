//
//  ViewController.swift
//  State Lab
//
//  Created by Byron on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label:UILabel!
    private var animate = true
    
    private var smiley:UIImage!
    private var smileyView:UIImageView!
    
    private var segmentedControl:UISegmentedControl!
    private var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let bounds = view.bounds
        let labelFrame = CGRect(x: bounds.origin.x,
                                y: bounds.midY - 50, width: bounds.size.width, height: 100)
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size:70)
        label.text = "Bazinga!"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        //rotateLabelDown()
        
        // smiley.png is 84 x 84
        let smileyFrame = CGRect(x: bounds.midX - 42,
                                 y: bounds.midY/2 - 42, width: 84, height: 84)
        
        smileyView = UIImageView(frame:smileyFrame)
        smileyView.contentMode = UIView.ContentMode.center
        let smileyPath =
            Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
        view.addSubview(smileyView)
        
        segmentedControl =
            UISegmentedControl(items: ["One","Two", "Three", "Four"])
        segmentedControl.frame = CGRect(x: bounds.origin.x + 20, y: 50,
                                        width: bounds.size.width - 40, height: 30)
        segmentedControl.addTarget(self, action: #selector(ViewController.selectionChanged(_:)),
                                   for: UIControl.Event.valueChanged)
        view.addSubview(segmentedControl)
        index = UserDefaults.standard.integer(forKey: "index")
        segmentedControl.selectedSegmentIndex = index;
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.applicationWillResignActive),
                           name: UIApplication.willResignActiveNotification, object: nil)
        
        center.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive),
                           name: UIApplication.didBecomeActiveNotification, object: nil)
        
        center.addObserver(self, selector: #selector(ViewController.applicationDidEnterBackground),
                           name: UIApplication.didEnterBackgroundNotification, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationWillEnterForeground),
                           name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func rotateLabelDown() {
        UIView.animate(withDuration: 1, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        },
                       completion: {(Bool) -> Void in
                        self.rotateLabelUp()
        }
        )
    }
    
    func rotateLabelUp() {
        UIView.animate(withDuration: 1, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: 0)
        },
                       completion: {(Bool) -> Void in
                        if self.animate {
                            self.rotateLabelDown()
                        }
        }
        )
    }
    
    @objc func applicationWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }
    
    @objc func applicationDidBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }
    
    @objc func selectionChanged(_ sender:UISegmentedControl) {
        index = segmentedControl.selectedSegmentIndex;
    }
    
    @objc func applicationWillEnterForeground() {
        print("VC: \(#function)")
        let smileyPath =
            Bundle.main.path(forResource: "smiley", ofType:"png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
    }
    
    @objc func applicationDidEnterBackground() {
        print("VC: \(#function)")
        UserDefaults.standard.set(self.index,
                                  forKey:"index")
        
        let app = UIApplication.shared
        var taskId = UIBackgroundTaskIdentifier.invalid
        let id = app.beginBackgroundTask() {
            print("Background task ran out of time and was terminated.")
            app.endBackgroundTask(taskId)
        }
        taskId = id
        
        if taskId == UIBackgroundTaskIdentifier.invalid {
            print("Failed to start background task!")
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            
            DispatchQueue.main.async {
                print("Starting background task with " +
                    "\(app.backgroundTimeRemaining) seconds remaining")
                self.smiley = nil;
                self.smileyView.image = nil;
            }
            
            // simulate a lengthy (25 seconds) procedure
            Thread.sleep(forTimeInterval: 10)
            
            DispatchQueue.main.async {
                print("Finishing background task with " +
                    "\(app.backgroundTimeRemaining) seconds remaining")
            }
            app.endBackgroundTask(taskId)
        }
    }
}

