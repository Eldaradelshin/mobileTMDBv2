//
//  DateService.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

class DateService {
    
    let currentDate = Date()
    let currentDateWeekEarlier = Date.init(timeIntervalSinceNow: -604800)
    let currentDateWeekLater = Date.init(timeIntervalSinceNow: 604800)
    
    func getFormattedDate(date: Date) -> String {
      let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
