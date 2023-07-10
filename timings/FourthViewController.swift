//
//  FourthViewController.swift
//  timings
//
//  Created by Денис Смолянинов on 10.07.2023.
//

import UIKit


class FourthViewController: UIViewController{

    override func viewDidLoad(){
        super.viewDidLoad()

        let pieChart = PieChartDraw()
        view.addSubview(pieChart.pieChartView)
        pieChart.pieChartView.centerInSuperview()
        pieChart.pieChartView.width(to: view)
        pieChart.pieChartView.heightToWidth(of: view)
        pieChart.setFullTimeData(path: "statistic")
    }
    

}
