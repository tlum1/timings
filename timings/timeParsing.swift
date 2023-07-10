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
        df.dateFormat = "yyyy.MM.dd"
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
    
    func addTime(a:String, b:String) -> String{
        let a_splt = a.split(separator: ":")
        let b_splt = b.split(separator: ":")
        
        var h = (Int(a_splt[0]) ?? 0)  + (Int(b_splt[0]) ?? 0)
        var m = (Int(a_splt[1]) ?? 0)  + (Int(b_splt[1]) ?? 0)
        var s = (Int(a_splt[2]) ?? 0)  + (Int(b_splt[2]) ?? 0)

        m = m + s / 60
        s = s % 60

        h = h + m / 60
        m = m % 60

        var timeString = ""
        timeString += String(format: "%02d", h)
        timeString += ":"
        timeString += String(format: "%02d", m)
        timeString += ":"
        timeString += String(format: "%02d", s)

        return timeString
        
    }
    
    func stringTimeToSec(sourceTime:String) -> Double{
        let spltTime = sourceTime.split(separator: ":")
        let h = (Int(spltTime[0]) ?? 0)
        let m = (Int(spltTime[1]) ?? 0)
        let s = (Int(spltTime[2]) ?? 0)
        
        return Double(h * 3600 + m * 60 + s)
    }
    
    
    func getDaysOfWeek(startDay:String) -> [String]{
        let gregorian = Calendar(identifier: .gregorian)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let date = dateFormatter.date(from: startDay)!
        
        var days: [String] = []
        
        for i in 0...6{
            days.append(self.getDateLikeYYYYMMDD(
                date: gregorian.date(byAdding: .day, value: i, to: date)!
                )
            )
        }
        return days
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

