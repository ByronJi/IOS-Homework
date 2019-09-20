//
//  ViewController.swift
//  PinchMe
//
//  Created by Byron on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    private var imageView:UIImageView!
    private var scale = CGFloat(1)
    private var preScale = CGFloat(1)
    private var rotation = CGFloat(0)
    private var preRotation = CGFloat(0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let image = UIImage(named: "pic")
        imageView = UIImageView(image:image)
        imageView.isUserInteractionEnabled = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        let pinchGes = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        pinchGes.delegate = self
        imageView.addGestureRecognizer(pinchGes)
        
        let rotationGes = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.doRotate(_:)))
        rotationGes.delegate = self
        imageView.addGestureRecognizer(rotationGes)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func transformImageView(){
        var t = CGAffineTransform(scaleX: scale*preScale, y: scale*preScale)
        t = t.rotated(by: rotation + preRotation)
        imageView.transform = t
        
    }
    
    @objc func doPinch(_ gesture:UIPinchGestureRecognizer){
        scale = gesture.scale
        transformImageView()
        if gesture.state == .ended{
            preScale = scale * preScale
            scale = 1
        }
    }
    
    @objc func doRotate(_ gesture:UIRotationGestureRecognizer){
        rotation = gesture.rotation
        transformImageView()
        if gesture.state == .ended{
            preRotation = rotation + preRotation
            rotation = 0
        }
    }
}

