//
//  EventViewCell.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/12/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {
    
    var eventTimeLabel:UILabel = UILabel()
    var eventTitleLabel:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        eventTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        eventTimeLabel.backgroundColor = UIColor.lightGray
        addSubview(eventTimeLabel)
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftTimeLabelConstraint = NSLayoutConstraint(item: eventTimeLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        
        let centerYTimeLabelConstraint = NSLayoutConstraint(item: eventTimeLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        addConstraints([leftTimeLabelConstraint, centerYTimeLabelConstraint])
        
        let timeLabelHeightConstraint = NSLayoutConstraint(item: eventTimeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        addConstraint(timeLabelHeightConstraint)
        
        eventTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        eventTitleLabel.backgroundColor = UIColor.lightGray
        addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftTitleLabelConstraint = NSLayoutConstraint(item: eventTitleLabel, attribute: .left, relatedBy: .equal, toItem: eventTimeLabel, attribute: .right, multiplier: 1, constant: 8)
        
        let centerYTitleLabelConstraint = NSLayoutConstraint(item: eventTitleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        addConstraints([leftTitleLabelConstraint, centerYTitleLabelConstraint])
        
        let titleLabelHeightConstraint = NSLayoutConstraint(item: eventTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        addConstraint(titleLabelHeightConstraint)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
