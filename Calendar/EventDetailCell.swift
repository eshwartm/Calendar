//
//  EventDetailCell.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/15/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit

class EventDetailCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
