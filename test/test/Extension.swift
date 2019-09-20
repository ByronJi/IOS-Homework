
//
//  Extension.swift
//  test
//
//  Created by Byron on 2019/4/26.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func loadFromNet(imageUrl:String){
        do{
            let url = URL(string: imageUrl)
            let nsdata = try Data(contentsOf: url!)
            self.image = UIImage(data: nsdata, scale: 1)
            self.contentMode = .scaleAspectFill
        }catch{
            
        }
    }
}
