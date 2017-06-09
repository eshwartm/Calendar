//
//  ViewController.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/6/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit
import CVCalendar

class ViewController: UIViewController {
    struct Color {
        static let selectedText = UIColor.white
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
        static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        static let sundaySelectionBackground = sundayText
    }

    @IBOutlet weak var agendaView: UITableView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    fileprivate var randomNumberOfDotMarkersForDay = [Int]()
    
    var selectedDay: CVCalendarDayView?
    
    var dateArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        agendaView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let dateString = dateFormatter.string(from: currentDate)
        print(dateString)
        
        dateArray = fetchDatesArray(dateString: dateString)
        
        let indexPath = IndexPath(row: 0, section: dateArray.count/2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.agendaView.scrollToRow(at: indexPath, at: .top, animated: false)
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.selectDateOnTopMostSection()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    private func randomizeDotMarkers() {
        randomNumberOfDotMarkersForDay = [Int]()
        for _ in 0...31 {
            randomNumberOfDotMarkersForDay.append(Int(arc4random_uniform(3) + 1))
        }
    }
    
    private func fetchDatesArray(dateString:String) -> [String] {
        // for date component reference
        /*let day = calendar.component(.day, from: date!)
         let month = calendar.component(.month, from: date!)*/
        
        var tempDateArray:[String] = []
        
        // define date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        // convert date string to date
        let str = dateString
        let date = dateFormatter.date(from: str)
        
        // make a for loop
        // add dates to the array, backward/forward 1000 from that date string
        for index in -1000...1000 {
            let calendar = Calendar.current
            let newDate = calendar.date(byAdding: .day, value: index, to: date!)
            print(newDate!)
            
            let dateString = dateFormatter.string(from: newDate!)
            print(dateString)
            
            tempDateArray.append(dateString)
        }
        agendaView.reloadData()
        
        return tempDateArray
    }
    
    func fetchEventForDate(dateString:String) -> String {
        return "Something \(dateString)"
    }
}

extension ViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        print("Selected Date : ")
        let cvDate = (selectedDay?.date)!
        print("\(cvDate.day) \(cvDate.month) \(cvDate.year)")
        
        let monthStr = getMonthFromIndex(monthIndex: cvDate.month)
        
        let completeDateString = "\(cvDate.day) \(monthStr) \(cvDate.year)"
        selectDateInAgendaView(dateString: completeDateString)
        
    }
    
    func getMonthFromIndex(monthIndex:Int) -> String {
        switch monthIndex {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
}

extension ViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
        case (.sunday, .in, _): return Color.sundayText
        case (.sunday, _, _): return Color.sundayTextDisabled
        case (_, .in, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        print(dateArray.count)
        return dateArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // let eventDateKey = dateArray[section]
        // return dateEventSection[eventDateKey].count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let eventString = fetchEventForDate(dateString: dateArray[indexPath.section])
        cell.textLabel?.text = eventString
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dateArray[section]
    }
    
    func firstVisibleSection(indexPaths:[IndexPath]) -> String {
        let dateString = dateArray[indexPaths[0].section]
        return dateString
    }
    
    func selectDateOnTopMostSection() {
        let visibleIndexPaths = self.agendaView.indexPathsForVisibleRows
        let selectedDateString = self.firstVisibleSection(indexPaths: visibleIndexPaths!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        var date = dateFormatter.date(from: selectedDateString)
        date = dateFormatter.date(from: selectedDateString)
        print(date!)
        
        selectDateOnCalendar(date: date!)
    }
    
    func selectDateInAgendaView(dateString: String) {
        if dateArray.count == 0 || dateString == "" {
            return
        }
        let indexOfDate = dateArray.index{$0 == dateString}
        if let index = indexOfDate {
            print("Index of date string : \(index)")
            let indexPath = IndexPath(row: 0, section: index)
            self.agendaView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func selectDateOnCalendar(date:Date) {
        calendarView.toggleViewWithDate(date)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == agendaView {
            selectDateOnTopMostSection()
        }
    }
    
    /*func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == agendaView {
            selectDateOnTopMostSection()
        }
    }*/
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == agendaView {
            selectDateOnTopMostSection()
        }
    }
    
}

