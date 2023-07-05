//
//  task.swift
//  timings
//
//  Created by Денис Смолянинов on 02.07.2023.
//

import Foundation

class Task{
    var name: String = ""
    var time: String = ""
    func writeTask(path:String) -> Void{
        
        let JSONHelper = servicesJSON()
        let parser = TimeParser()
        
        let date = parser.getDateLikeYYYYMMDD(date: Date())
        let week = parser.getWeekStartEndFromDate(date: Date())
        
        var data:  Dictionary<String, Dictionary<String, Dictionary<String, String>>> = JSONHelper.loadJSON(withFilename: path) as! Dictionary<String, Dictionary<String, Dictionary<String, String>>>

        
        let containsWeek = data.contains{$0.key == week}

        if containsWeek{
            let containsDate = data[week]!.contains{$0.key == date}
            if containsDate{
                let containsCategory = data[week]![date]!.contains{$0.key == name}
                if containsCategory{
                    let newTime = parser.addTime(a: data[week]![date]![name]!, b: time)
                    data[week]![date]![name]! = newTime
                }else{
                    data[week]![date]![name] = time
                }
            }else{
                data[week]![date] = [name:time]
            }
        }else{
            data[week] = [date:[name:time]]
        }
        print("\(data as AnyObject)")
        
        JSONHelper.saveToJSON(toFilename: path, jsonObject: data)
    }
    
}

/*
 TODO
 - Складывать время Done
 - Сохранять данные Done
 - Научиться рисовать графики
 - Добавить кнопку для отображения статистики
 - Добавить handler когда поле категории пустое
 - Добавить статистику за неделю (возможно сделать карусель)
 - Добавить full-time статистику
 - Добавить еженедельные уведомления со статистикой
 - Добавить возможность экспорта статистики
 */
