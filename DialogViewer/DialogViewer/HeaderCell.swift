//
//  HeaderCell.swift
//  DialogViewer
//
//  Created by Byron on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class HeaderCell: ContentCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        label.backgroundColor = UIColor(red: 0.9,green: 0.9,blue: 0.8,alpha: 1.0)
        label.textColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func defaultFont() -> UIFont{
        return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    }
    
}
