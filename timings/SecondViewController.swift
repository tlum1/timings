//
//  SecondViewController.swift
//  timings
//
//  Created by Денис Смолянинов on 07.07.2023.
//

import UIKit


class SecondViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        titleLabel.text = "Week"
        weekLabel.alpha = 1

        let barChart = BarChartDraw()
        view.addSubview(barChart.barChartView)
        barChart.barChartView.centerInSuperview()
        barChart.barChartView.width(to: view)
        barChart.barChartView.heightToWidth(of: view)
        barChart.setData(path: "statistic")
        weekLabel.text = "\(barChart.week)"
    
    }
}
