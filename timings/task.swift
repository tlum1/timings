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
        print("writing data to file \(path).json")
        print("name:\(self.name), time: \(self.time)")
        
        let JSONHelper = servicesJSON()
        let parser = TimeParser()
        
        let date = parser.getDateLikeYYYYMMDD(date: Date())
        let week = parser.getWeekStartEndFromDate(date: Date())
        
        print(date)
        print(week)
        
        var data:  Dictionary<String, Dictionary<String, Dictionary<String, String>>> = JSONHelper.readJSON(fileName: path)
        
        for (key, value) in data {
            print("\(key) - \(value)")
        }
        
        var containsWeek = data.contains{$0.key == week}
        
        if containsWeek{
            var containsDate = data[week]!.contains{$0.key == date}
            if containsDate{
                var containsCategory = data[week]![date]!.contains{$0.key == name}
                if containsCategory{
                    // Подумать как лучше складывать время: в строках или переводить все в Date() и там складывать
                }else{
                    data[week]![date]![name] = time
                }
            }else{
                data[week]![date] = [name:time]
            }
        }else{
            data[week] = [date:[name:time]]
        }
            
    }
    
}

/*
 TODO
 - Складывать время
 - Сохранять данные
 - Научиться рисовать графики
 - Добавить кнопку для отображения статистики
 - Добавить handler когда поле категории пустое
 - Добавить статистику за неделю (возможно сделать карусель)
 - Добавить full-time статистику
 - Добавить еженедельные уведомления со статистикой
 - Добавить возможность экспорта статистики
 */
