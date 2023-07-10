//
//  chart.swift
//  timings
//
//  Created by Денис Смолянинов on 05.07.2023.
//

import Foundation
import TinyConstraints
import DGCharts

class PieChartDraw{
    
    var week: String = ""
    var dataPoints: [String] = []
    var dataEntries: [Double] = []
    
    lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
//        chartView.backgroundColor = .systemFill
    
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .center
        chartView.legend.orientation = Legend.Orientation.vertical
        chartView.drawEntryLabelsEnabled = false
       
        return chartView
    }()
    
    func _truncateCategories(categories:Dictionary<String,String>)-> Dictionary<String,String>{
        let parser = TimeParser()
        let sortedKeys = Array(categories.keys).sorted(by:<)
        var totalLessThan5Percent: Double = 0
        var totalSec: Double = 0
        
        for cat in sortedKeys{
            totalSec = totalSec + parser.stringTimeToSec(sourceTime: categories[cat]!)
        }
        
        for cat in sortedKeys{
            let sec = parser.stringTimeToSec(sourceTime: categories[cat]!) / totalSec * 100
            if sec > 5{
                self.dataPoints.append("\(cat) - \(categories[cat]!)")
                self.dataEntries.append(sec)
            }else{
                totalLessThan5Percent = totalLessThan5Percent + sec
            }
        }
        
        self.dataPoints.append("Other")
        self.dataEntries.append(totalLessThan5Percent)
        
        return categories
        
    }
    
    func _getValues(path:String) -> Dictionary<String,String>{
        let JSONHelper = servicesJSON()
        let parser = TimeParser()
        var categories:Dictionary<String,String> = [:]
        
        let data:  Dictionary<String, Dictionary<String, Dictionary<String, String>>> = JSONHelper.loadJSON(withFilename: path) as! Dictionary<String, Dictionary<String, Dictionary<String, String>>>
        
        if data.isEmpty{
            print("data is empty")
        }else{
            let sortedKeys = Array(data.keys).sorted(by:>)
            let week = sortedKeys[0]
            self.week = week
            for (_,  cats) in data[week]!{
                for (cat, catTime) in cats{
                    let containsCat = categories.contains{$0.key == cat}
                    if containsCat{
                        categories[cat]! = parser.addTime(a: categories[cat]!, b: catTime)
                    }else{
                        categories[cat] = catTime
                    }
                }
            }
        }
        
       return _truncateCategories(categories: categories)
    }
    
    
    func _getFullTimeValues(path:String) -> Dictionary<String,String>{
        let JSONHelper = servicesJSON()
        let parser = TimeParser()
        var categories:Dictionary<String,String> = [:]
        
        let data:  Dictionary<String, Dictionary<String, Dictionary<String, String>>> = JSONHelper.loadJSON(withFilename: path) as! Dictionary<String, Dictionary<String, Dictionary<String, String>>>
        
        if data.isEmpty{
            print("data is empty")
        }else{
            for week in data.keys{
                for (_,  cats) in data[week]!{
                    for (cat, catTime) in cats{
                        let containsCat = categories.contains{$0.key == cat}
                        if containsCat{
                            categories[cat]! = parser.addTime(a: categories[cat]!, b: catTime)
                        }else{
                            categories[cat] = catTime
                        }
                    }
                }
            }
        }
        
        return _truncateCategories(categories: categories)
    }
    
    
    
    func _getPieChartDataEntries(categories:Dictionary<String,String>) -> [PieChartDataEntry]{
        var values: [PieChartDataEntry] = []
        
        for i in 0..<self.dataPoints.count {
            let dataEntry = PieChartDataEntry(value: self.dataEntries[i], label: self.dataPoints[i])
            values.append(dataEntry)
        }
        
        return values
    }
    
    
    func _setData(values: [PieChartDataEntry]){
        var  colors: [UIColor] = []
        for _ in 0..<values.count {
            let red = Double(arc4random_uniform(256)) / 1.5
            let green = Double(arc4random_uniform(256)) / 1.5
            let blue = Double(arc4random_uniform(256)) / 1.5

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"

        
        let set1 = PieChartDataSet(entries: values, label:"")
        set1.colors = colors

        let data = PieChartData(dataSet: set1)
        
        self.pieChartView.data = data
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
    
    func setWeekData(path:String){
        let values = self._getPieChartDataEntries(categories: self._getValues(path: path))
        _setData(values: values)
    }
    
    func setFullTimeData(path:String){
        let values = self._getPieChartDataEntries(categories: self._getFullTimeValues(path: path))
        
        _setData(values: values)
    }
    
    
    /*
     TODO
      - Поменять лейблы done
      - Добавить проценты done
      - Изменить легенду: Сделать таблицу вида "Цвет-Занятие-Время" done
      - Добавить подпись недели done
      - Считать время в секундах done
      - label для PieChartDataEntry будут проценты done
     */
}

class BarChartDraw{
    var week: String = ""
    var dataPoints: [String] = []
    var dataEntries: [Double] = []
    
    lazy var barChartView: BarChartView = {
        
        let chartView = BarChartView()
        chartView.legend.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .top
        chartView.xAxis.labelCount = 7
        chartView.xAxis.labelRotationAngle = 0.0
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.granularity = 1
        chartView.xAxis.axisMinimum = 0
//        chartView.xAxis.centerAxisLabelsEnabled = true
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.axisMaximum = 7
        chartView.xAxis.axisRange = 1
        
        chartView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        
        
        return chartView
    }()
    
    
    func _fillDaysOfWeek(week:String) -> Dictionary<String,String>{
        let parser = TimeParser()
        
        var dates:Dictionary<String,String> = [:]
        let startDay = week.split(separator: " - ")[0]
        
        for day in parser.getDaysOfWeek(startDay: String(startDay)){
            dates[day] = "00:00:00"
        }
        
        return dates
    }
    
    func _getValues(path:String) -> Dictionary<String,String>{
        let JSONHelper = servicesJSON()
        let parser = TimeParser()
        var dates:Dictionary<String,String> = [:]
        let data:  Dictionary<String, Dictionary<String, Dictionary<String, String>>> = JSONHelper.loadJSON(withFilename: path) as! Dictionary<String, Dictionary<String, Dictionary<String, String>>>
        if data.isEmpty{
            print("data is empty")
        }else{
            
            
            let sortedKeys = Array(data.keys).sorted(by:>)
            let week = sortedKeys[0]
            self.week = week
            dates = self._fillDaysOfWeek(week: self.week)
            
            for (day,  cats) in data[week]!{
                let containsDay = dates.contains{$0.key == day}
                if containsDay{
                    for (_, catTime) in cats{
                        dates[day]! = parser.addTime(a: dates[day]!, b: catTime)
                    }
                }
            }
        }
        
        let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        let sortedKeys = Array(dates.keys).sorted(by:<)
        var i = 0
        for day in sortedKeys{
            let sec = parser.stringTimeToSec(sourceTime: dates[day]!)
            self.dataPoints.append("\(weekdays[i])\n\(dates[day]!)")
            self.dataEntries.append(sec)
            i = i + 1
        }
        
        return dates
    }
    
    func _getBarChartDataEntries(categories:Dictionary<String,String>) -> [BarChartDataEntry]{
        var values: [BarChartDataEntry] = []
        
        for i in 0..<self.dataEntries.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: self.dataEntries[i], data: self.dataPoints[i])
            values.append(dataEntry)
        }
        
        return values
    }
    
    func setData(path: String){
        let values = self._getBarChartDataEntries(categories: self._getValues(path: path))
        
        let set1 = BarChartDataSet(entries: values, label:"Time spending")
        set1.colors = ChartColorTemplates.joyful()
    
        let data = BarChartData( dataSet: set1)
        data.barWidth = 1
        self.barChartView.data = data
        
        self.barChartView.data?.setDrawValues(false)
        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.dataPoints)

    }
    
}


/*
 TODO
 - Сделать так, чтобы выбиралась последняя выбранная неделя
 */
