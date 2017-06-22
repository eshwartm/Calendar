//
//  AddEditViewController.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/17/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit


let EVENT_TITLE_CELL = "EventTitleCell"
let EVENT_DESCRIPTION_CELL = "EventDescriptionCell"
let DATE_TIME_PICKER = "DateTimePickerCell"

let TITLE_TAG = 0
let DESCRIPTION_TAG = 1
let START_DATE_TIME_TAG = 2
let END_DATE_TIME_TAG = 3

class AddEditViewController: UITableViewController {
    
    var datePicker:UIDatePicker?
    var currentlyActiveCell:DateTimePickerCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        datePicker = UIDatePicker(frame: CGRect.zero)
        datePicker?.addTarget(self, action: #selector(pickerValueChanged), for: UIControlEvents.valueChanged)
        
        /*tableView.register(EventTitleCell.self, forCellReuseIdentifier: EVENT_TITLE_CELL)
        tableView.register(EventDescriptionCell.self, forCellReuseIdentifier: EVENT_DESCRIPTION_CELL)
        tableView.register(DateTimePickerCell.self, forCellReuseIdentifier: DATE_TIME_PICKER)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == TITLE_TAG {
            let cell = tableView.dequeueReusableCell(withIdentifier: EVENT_TITLE_CELL, for: indexPath) as! EventTitleCell
            cell.tag = indexPath.row
            return cell
        }
        else if indexPath.row == DESCRIPTION_TAG {
            let cell = tableView.dequeueReusableCell(withIdentifier: EVENT_DESCRIPTION_CELL, for: indexPath) as! EventDescriptionCell
            cell.tag = indexPath.row
            return cell
        }
        else if indexPath.row == START_DATE_TIME_TAG || indexPath.row == END_DATE_TIME_TAG {
            let cell = tableView.dequeueReusableCell(withIdentifier: DATE_TIME_PICKER, for: indexPath) as! DateTimePickerCell
            cell.tag = indexPath.row
            
            if indexPath.row == START_DATE_TIME_TAG {
                cell.dateTimeTextField.placeholder = "Start Date And Time"
            }
            else {
                cell.dateTimeTextField.placeholder = "End Date And Time"
            }
            cell.dateTimeTextField.delegate = self
            cell.dateTimeTextField.inputView = datePicker!
            
            
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
            let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissDatePicker))
            toolBar.items = [doneBarButtonItem]
            cell.dateTimeTextField.inputAccessoryView = toolBar
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == DESCRIPTION_TAG {
            return 150
        }
        return 50
    }

    func pickerValueChanged(sender: UIDatePicker) {
        if let activeCell = currentlyActiveCell {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY HH:MM"
            let dateString = dateFormatter.string(from: sender.date)
            activeCell.dateTimeTextField.text = dateString
        }
    }
    
    func dismissDatePicker() {
        currentlyActiveCell?.dateTimeTextField.resignFirstResponder()
    }
    
    @IBAction func cancelEventCreation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createEvent(_ sender: UIBarButtonItem) {
        // make object of current event 
        // send it and notify calendar 
        makeEvent()
        dismiss(animated: true, completion: nil)
    }
    
    func makeEvent() {
        /*var title = "", desc = "", startTime = "", endTime = "", duration = ""
        
        let titleCell = tableView.viewWithTag(TITLE_TAG) as! EventTitleCell
        let titleString = titleCell.titleLabel.text
        
        let descriptionCell = tableView.viewWithTag(DESCRIPTION_TAG) as! EventDescriptionCell
        let descriptionString = descriptionCell.descriptionTextView.text
        
        let startDateTimeCell = tableView.viewWithTag(START_DATE_TIME_TAG) as! DateTimePickerCell
        let startDateTimeString = startDateTimeCell.dateTimeTextField.text
        
        let endDateTimeCell = tableView.viewWithTag(END_DATE_TIME_TAG) as! DateTimePickerCell
        let endDateTimeString = endDateTimeCell.dateTimeTextField.text
        
        let valid = checkForValidityOfStartAndEndDate(startDateString: startDateTimeString!, endDateString: endDateTimeString!)
        
        if valid {
            
        }*/
        
        // event = Event(title: <#T##String#>, desc: <#T##String#>, startTime: <#T##String#>, endTime: <#T##String#>, duration: <#T##String#>)
    }
    
    func checkForValidityOfStartAndEndDate(startDateString:String, endDateString:String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY HH:MM"
        
        let startDate = dateFormatter.date(from: startDateString)
        let endDate = dateFormatter.date(from: endDateString)
        
        if startDate!.compare(endDate!) == .orderedAscending {
            return true
        }
        return false
    }
}

extension AddEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentlyActiveCell = textField.superview?.superview as? DateTimePickerCell
        if currentlyActiveCell!.tag == START_DATE_TIME_TAG || currentlyActiveCell!.tag == END_DATE_TIME_TAG {
            datePicker?.becomeFirstResponder()
        }
    }
}
