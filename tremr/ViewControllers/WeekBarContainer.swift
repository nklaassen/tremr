//
//  WeekBarContainer.swift
//  tremr
//
//  Created by Kira Nishi Beckingham on 2018-11-01.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
//  This file sets the bar chart for week view
//

import Charts
import Foundation
import UIKit

class WeekBarContainer: UIViewController {

    @IBOutlet weak var weekBarChartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let dates = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", ""]
        let medication = [1.0, 0.0, 0.0, 1.0, 2.0, 3.0, 0.0, 4.0]
        let exercise = [0.0, 0.0, 3.0, 0.0, 1.0, 1.0, 3.0, 4.0]
    
        setChart(dataPoints: dates, values1: medication, values2: exercise)
        
        //format chart
        self.weekBarChartView.chartDescription?.text = ""
        
        //format xAxis
        self.weekBarChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.weekBarChartView.leftAxis.axisMinimum = 0
        self.weekBarChartView.xAxis.centerAxisLabelsEnabled = true
        self.weekBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.weekBarChartView.xAxis.setLabelCount(dates.count, force: true)
        self.weekBarChartView.xAxis.axisMinimum = 0
        self.weekBarChartView.xAxis.granularityEnabled = true
        self.weekBarChartView.xAxis.granularity = 1
        self.weekBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        //format yAxis
        self.weekBarChartView.leftAxis.drawAxisLineEnabled = false
        self.weekBarChartView.leftAxis.drawGridLinesEnabled = false
        self.weekBarChartView.leftAxis.drawLabelsEnabled = false
        self.weekBarChartView.rightAxis.drawLabelsEnabled = false
    }

    // sets up the chart data for week view bar chart
    func setChart(dataPoints: [String], values1: [Double], values2: [Double]) {
        self.weekBarChartView.noDataText = "no data provided"
    
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values1[i])
        }
        
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values2[i])
        }
        
        //format bars
        let groupSpace = 0.25
        let barSpace = 0.01
        let barWidth = 0.2
        let yVals1 = (0 ..< dataPoints.count).map(block1)
        let yVals2 = (0 ..< dataPoints.count).map(block2)
    
        let set1: BarChartDataSet = BarChartDataSet(values: yVals1, label: "medications missed")
        
        set1.setColor(UIColor.yellow)
    
        let set2: BarChartDataSet = BarChartDataSet(values: yVals2, label: "exercises missed")
        
        set2.setColor(UIColor.red)

        //add both data sets together
        var dataSets : [BarChartDataSet] = [BarChartDataSet] ()
        dataSets.append(set1)
        dataSets.append(set2)
    
        let data: BarChartData = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth*2
        data.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        
        //add data to graph
        self.weekBarChartView.data = data
    }
}
