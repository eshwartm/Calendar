//
//  ViewController.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/6/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit
import NSDate_Escort
import MJCalendar
import HexColors

let EVENT_CELL_ID = "EventCellIdentifier"

struct DayColors {
    var backgroundColor: UIColor
    var textColor: UIColor
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MJCalendarViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var calendarView: MJCalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    var eventDict:[String:Any] = [
            "December 14, 2016": [
        
                [
                    "title": "Go to Gym",
                    "time" : "6:00 AM"
                ],
                [
                    "title": "Meditation",
                    "time" : "8:00 PM"
                ],
                [
                    "title": "Something",
                    "time" : "8:00 PM"
                ],
                [
                    "title": "Meet with Jill",
                    "time" : "8:00 PM"
                ]
            ],
            "December 15, 2016": [
                
                [
                    "title": "Meet with John",
                    "time" : "8:00 PM"
                ],
                [
                    "title": "Meet with Jack",
                    "time" : "8:00 PM"
                ]
            ]
    ]
    
    var dayColors = Dictionary<Date, DayColors>()
    var dateFormatter: DateFormatter!
    var colors: [UIColor] {
        return [
            UIColor(hexString: "#f6980b"),
            UIColor(hexString: "#2081D9"),
            UIColor(hexString: "#2fbd8f"),
        ]
    }
    
    let daysRange = 365
    var isScrollingAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setUpCalendarConfiguration()
        
        self.dateFormatter = DateFormatter()
        self.setTitleWithDate(Date())
        
        tableView.register(EventViewCell.self, forCellReuseIdentifier:EVENT_CELL_ID)
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(switchCalendarToMonthView))
        swipeGestureRecognizerUp.delegate = self
        swipeGestureRecognizerUp.direction = .up
        calendarView.addGestureRecognizer(swipeGestureRecognizerUp)
        
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(switchCalendarToMonthView))
        swipeGestureRecognizerDown.delegate = self
        swipeGestureRecognizerDown.direction = .down
        calendarView.addGestureRecognizer(swipeGestureRecognizerDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpCalendarConfiguration() {
        self.calendarView.calendarDelegate = self
        
        // Set displayed period type. Available types: Month, ThreeWeeks, TwoWeeks, OneWeek
        self.calendarView.configuration.periodType = .month
        
        // Set shape of day view. Available types: Circle, Square
        self.calendarView.configuration.dayViewType = .circle
        
        // Set selected day display type. Available types:
        // Border - Only border is colored with selected day color
        // Filled - Entire day view is filled with selected day color
        self.calendarView.configuration.selectedDayType = .border
        
        // Set width of selected day border. Relevant only if selectedDayType = .Border
        self.calendarView.configuration.selectedBorderWidth = 1
        
        // Set day text color
        self.calendarView.configuration.dayTextColor = UIColor(hexString: "6f787c")
        
        // Set day background color
        self.calendarView.configuration.dayBackgroundColor = UIColor(hexString: "f0f0f0")
        
        // Set selected day text color
        self.calendarView.configuration.selectedDayTextColor = UIColor.white
        
        // Set selected day background color
        self.calendarView.configuration.selectedDayBackgroundColor = UIColor(hexString: "6f787c")
        
        // Set other month day text color. Relevant only if periodType = .Month
        self.calendarView.configuration.otherMonthTextColor = UIColor(hexString: "6f787c")
        
        // Set other month background color. Relevant only if periodType = .Month
        self.calendarView.configuration.otherMonthBackgroundColor = UIColor(hexString: "E7E7E7")
        
        // Set week text color
        self.calendarView.configuration.weekLabelTextColor = UIColor(hexString: "6f787c")
        
        // Set start day. Available type: .Monday, Sunday
        self.calendarView.configuration.startDayType = .sunday
        
        // Set number of letters presented in the week days label
        self.calendarView.configuration.lettersInWeekDayLabel = .one
        
        // Set day text font
        self.calendarView.configuration.dayTextFont = UIFont.systemFont(ofSize: 12)
        
        //Set week's day name font
        self.calendarView.configuration.weekLabelFont = UIFont.systemFont(ofSize: 12)
        
        //Set day view size. It includes border width if selectedDayType = .Border
        self.calendarView.configuration.dayViewSize = CGSize(width: 24, height: 24)
        
        //Set height of row with week's days
        self.calendarView.configuration.rowHeight = 30
        
        // Set height of week's days names view
        self.calendarView.configuration.weekLabelHeight = 25
        
        // To commit all configuration changes execute reloadView method
        self.calendarView.reloadView()
    }
    
    func calendar(_ calendarView: MJCalendarView, backgroundForDate date: Date) -> UIColor? {
        return self.dayColors[date]?.backgroundColor
    }
    
    func calendar(_ calendarView: MJCalendarView, textColorForDate date: Date) -> UIColor? {
        return self.dayColors[date]?.textColor
    }
    
    func calendar(_ calendarView: MJCalendarView, didSelectDate date: Date) {
        self.scrollTableViewToDate(date)
    }
    
    func setTitleWithDate(_ date: Date) {
        self.dateFormatter.dateFormat = "MMMM yy"
        self.navigationItem.title = self.dateFormatter.string(from: date)
    }

    
    //MARK: MJCalendarViewDelegate
    func calendar(_ calendarView: MJCalendarView, didChangePeriod periodDate: Date, bySwipe: Bool) {
        // Sets month name according to presented dates
        self.setTitleWithDate(periodDate)
        
        // bySwipe diffrentiate changes made from swipes or select date method
        if bySwipe {
            // Scroll to relevant date in tableview
            //            self.scrollTableViewToDate(periodDate)
        }
    }

    func dateByIndex(_ index: Int) -> Date {
        let startDay = ((Date() as NSDate).atStartOfDay() as NSDate).subtractingDays(self.daysRange / 2)
        let day = (startDay as NSDate).addingDays(index)
        return day
    }
    
    func scrollTableViewToDate(_ date: Date) {
        if let row = self.indexByDate(date) {
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
            self.isScrollingAnimation = true
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func indexByDate(_ date: Date) -> Int? {
        let startDay = ((Date() as NSDate).atStartOfDay() as NSDate).subtractingDays(self.daysRange / 2)
        let index = (date as NSDate).days(after: startDay)
        if index >= 0 && index <= self.daysRange {
            return index
        } else {
            return nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.daysRange
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let date = self.dateByIndex(section)
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = self.dateFormatter.string(from: date)
        
        if let events = eventDict[dateString] as? [[String:Any]] {
            return events.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = self.dateByIndex(section)
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = self.dateFormatter.string(from: date)
        return dateString
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EVENT_CELL_ID, for: indexPath) as! EventViewCell
        
        let date = self.dateByIndex(indexPath.section)
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = self.dateFormatter.string(from: date)
        // got date string from section
        // now search by section in the dict
        
        if let events = eventDict[dateString] as? [[String:Any]] {
            cell.eventTimeLabel.text = events[indexPath.row]["time"] as? String
            cell.eventTitleLabel.text = events[indexPath.row]["title"] as? String
        } else {
            cell.eventTimeLabel.text = ""
            cell.eventTitleLabel.text = "No events"
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected event ")
        let date = self.dateByIndex(indexPath.section)
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        let dateString = self.dateFormatter.string(from: date)
        // got date string from section
        // now search by section in the dict
        
        if let events = eventDict[dateString] as? [[String:Any]] {
            print(events[indexPath.row])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Prevent changing selected day when non user scroll is triggered.
        if !isScrollingAnimation {
            if scrollView == tableView {
                if calendarView.configuration.periodType == .month {
                    self.animateToPeriod(.twoWeeks)
                }
            }
            // Get all visible cells from tableview
            if let visibleCells = self.tableView.indexPathsForVisibleRows {
                if let cellIndexPath = visibleCells.first {
                    // Get day by indexPath
                    let day = self.dateByIndex(cellIndexPath.section)
                    
                    //Select day according to first visible cell in tableview
                    self.calendarView.selectDate(day)
                }
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.isScrollingAnimation = false
    }

    func animateToPeriod(_ period: MJConfiguration.PeriodType) {
        self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
        
        self.calendarView.animateToPeriodType(period, duration: 0.2, animations: { (calendarHeight) -> Void in
            // In animation block you can add your own animation. To adapat UI to new calendar height you can use calendarHeight param
            self.calendarViewHeight.constant = calendarHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func switchCalendarToMonthView() {
        if calendarView.configuration.periodType == .twoWeeks {
            self.animateToPeriod(.month)
        }
    }
}

