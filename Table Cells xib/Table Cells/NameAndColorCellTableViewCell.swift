//
//  NameAndColorCellTableViewCell.swift
//  Table Cells
//
//  Created by Byron on 2019/3/30.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class NameAndColorCellTableViewCell: UITableViewCell {

    var name:String = ""{
        didSet{
            if(name != oldValue){
                nameLabel.text = name
            }
        }
    }
    var color:String = ""{
        didSet{
            if(color != oldValue){
                colorLabel.text = color
            }
        }
    }
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var colorLabel:UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
