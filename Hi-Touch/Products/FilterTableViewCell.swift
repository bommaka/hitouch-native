//
//  FilterTableViewCell.swift
//  Hi-Touch
//
//  Created by Swathi B on 26/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet private weak var customTitleLabel: UILabel!
    @IBOutlet weak var customTitleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        selectedBackgroundView? = UIView()
        selectedBackgroundView?.backgroundColor = .clear
    }
    
    func setup(withTitle title: String, detailsText: String, level : Int) {
        customTitleLabel.text = title
        detailsLabel.text = detailsText
        self.backgroundView = UIView()
        
        var color: UIColor
        if level == 0 {
            color = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 0.25)
        } else if level == 1 {
            color = UIColor(red: 209.0/255.0, green: 238.0/255.0, blue: 252.0/255.0, alpha: 0.25)
        } else {
            color = UIColor(red: 224.0/255.0, green: 248.0/255.0, blue: 216.0/255.0, alpha: 0.25)
        }
        
        self.backgroundView?.backgroundColor = color
        
        let left = 30 + 40 * CGFloat(level)
        self.customTitleLabelLeadingConstraint.constant = left
}
}
