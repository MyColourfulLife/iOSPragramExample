//
//  ItemCell.swift
//  Homepwner
//
//  Created by 黄家树 on 2018/3/23.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLable:UILabel!
    @IBOutlet var serialNumberLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!
    
    func updateLables() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLable.font = bodyFont
        valueLabel.font = bodyFont
        let caption1Font = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = caption1Font
    }
    
    func updateColor() {
        let value = valueLabel.text!
        let res = value[value.index(value.startIndex, offsetBy: 1)..<value.endIndex]
        if let number = Int(res) {
            contentView.backgroundColor = number < 50 ? UIColor.green : UIColor.red
        }
    }
    
}
