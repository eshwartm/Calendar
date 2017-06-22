//
//  EventDetailsTableViewController.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/14/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit

class EventDetailsTableViewController: UITableViewController {

    var eventDetailObject:[String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventDetailCell", for: indexPath) as! EventDetailCell
        // Configure the cell...
        
        if let detail = eventDetailObject {
            if let startTime = detail["start_time"] as? String, let endTime = detail["end_time"] as? String {
                let timeString = "\(startTime) - \(endTime) "
                cell.eventTimeLabel.text = timeString
            }
            
            cell.eventTitleLabel.text = detail["title"] as! String
            cell.eventDescriptionLabel.text = detail["description"] as! String
        }
        return cell
    }
    
}
