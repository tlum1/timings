//
//  ThirdViewController.swift
//  timings
//
//  Created by Денис Смолянинов on 10.07.2023.
//

import UIKit

class ThirdViewController: UIViewController{

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        titleLabel.text = "Week"
        weekLabel.alpha = 1

        let pieChart = PieChartDraw()
        view.addSubview(pieChart.pieChartView)
        pieChart.pieChartView.centerInSuperview()
        pieChart.pieChartView.width(to: view)
        pieChart.pieChartView.heightToWidth(of: view)
        pieChart.setData(path: "statistic")
        weekLabel.alpha = 1
        weekLabel.text = "\(pieChart.week)"
    
    }
    

}
