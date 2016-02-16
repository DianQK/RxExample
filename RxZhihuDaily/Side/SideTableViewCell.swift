//
//  SideTableViewCell.swift
//  RxExample
//
//  Created by 宋宋 on 16/2/15.
//  Copyright © 2016年 DianQK. All rights reserved.
//

import UIKit

class SideTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
        selectedBackgroundView = UIView()
        selectedBackgroundView!.backgroundColor = Config.Color.selectedColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLabel.highlighted = selected
        

    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }

}
