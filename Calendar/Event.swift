//
//  Event.swift
//  Calendar
//
//  Created by Eshwar Ramesh on 6/20/17.
//  Copyright © 2017 Eshwar Ramesh. All rights reserved.
//

import UIKit

class Event: NSObject {
    var title:String = ""
    var descriptionOfEvent:String = ""
    var startTime:String = ""
    var endTime:String = ""
    var duration:String = ""
    
    init(title: String, desc: String, startTime: String, endTime: String, duration: String) {
        super.init()
        self.title = title
        self.descriptionOfEvent = desc
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
    }
}
