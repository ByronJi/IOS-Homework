//
//  NewsTableViewCell.swift
//  test
//
//  Created by Byron on 2019/4/26.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var NewsDate: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
