//
//  timeParsing.swift
//  timings
//
//  Created by Денис Смолянинов on 02.07.2023.
//

import Foundation


class TimeParser{
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds / 3600), (seconds % 3600 / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func getDateLikeYYYYMMDD(date:Date) -> String{
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date)
    }
    
    func getWeekStartEndFromDate(date:Date) -> String{
        var startDay: String = ""
        var endDay: String = ""
        
        if let startDate = date.startOfWeek{
            startDay = self.getDateLikeYYYYMMDD(date: startDate)
            
        }
        if let endDate = date.endOfWeek {
            endDay = self.getDateLikeYYYYMMDD(date: endDate)
        }
      
        
        return "\(startDay) - \(endDay)"
    }
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}

