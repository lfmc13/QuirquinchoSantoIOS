//
//  TimelineCell.swift
//  NavTransition
//
//  Created by Tope Abayomi on 21/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class TimelineCell : UITableViewCell {
    
    @IBOutlet var typeImageView : UIImageView!
    @IBOutlet var profileImageView : UIImageView!
    @IBOutlet var dateImageView : UIImageView!
    @IBOutlet var photoImageView : UIImageView?
    
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var postLabel : UILabel?
    @IBOutlet var dateLabel : UILabel!
    
    override func awakeFromNib() {
        
        dateImageView.image = UIImage(named: "clock")
        profileImageView.layer.cornerRadius = 30
        
        nameLabel.font = UIFont(name: "Avenir-Book", size: 15)
        nameLabel.textColor = UIColor.blueColor()
        
        postLabel?.font = UIFont(name: "Avenir-Book", size: 12)
      //  postLabel?.textColor = UIColor(white: 0.6, alpha: 1.0)
        postLabel?.textColor = UIColor.blueColor()
        
        dateLabel.font = UIFont(name: "Avenir-Book", size: 10)
        dateLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        //dateLabel.textColor = UIColor.blueColor()
        
        photoImageView?.layer.borderWidth = 0.4
        photoImageView?.layer.borderColor = UIColor(white: 0.92, alpha: 1.0).CGColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if postLabel != nil {
            let label = postLabel!
            label.preferredMaxLayoutWidth = CGRectGetWidth(label.frame)
        }
    }
}