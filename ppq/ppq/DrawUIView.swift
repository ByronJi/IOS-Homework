//
//  DrawUIView.swift
//  ppq
//
//  Created by Byron on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DrawUIView: UIView {

    private var firstTouchLocation = CGPoint.zero
    private var lastTouchLocation = CGPoint.zero
    private var currentRect = CGRect.zero
    private var redrawRect = CGRect.zero
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstTouchLocation = (touches.first?.location(in:self))!
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchLocation = (touches.first?.location(in: self))!
        currentRect = CGRect(x:firstTouchLocation.x,y: firstTouchLocation.y,width: lastTouchLocation.x - firstTouchLocation.x,height: lastTouchLocation.y - firstTouchLocation.y)
        redrawRect = redrawRect.union(currentRect)
        setNeedsDisplay(redrawRect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(lastTouchLocation)
        print(touches.first?.location(in: self) as Any)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setFillColor(UIColor.blue.cgColor)
        
        context?.addRect(currentRect)
        context?.drawPath(using: .fillStroke)
    }
}
