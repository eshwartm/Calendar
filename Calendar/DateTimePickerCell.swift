//
//  DateTimePickerCell.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/17/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit

class DateTimePickerCell: UITableViewCell {

    @IBOutlet weak var dateTimeTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}