//
//  Name of file: YearBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs:

import Charts
import Foundation
import UIKit

class YearBarContainer: UIViewController {
    
    @IBOutlet weak var yearBarChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dates = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
        let medication = [9.0, 4.0, 5.0, 7.0, 9.0, 20.0, 13.0, 2.0, 8.0, 7.0, 17.0, 11.0, 22]
        let exercise = [4.0, 6.0, 3.0, 8.0, 9.0, 15.0, 13.0, 5.0, 8.0, 16.0, 21.0, 14.0, 22]
        
        setChart(dataPoints: dates, values1: medication, values2: exercise)
        
        //format chart
        self.yearBarChartView.chartDescription?.text = ""
        
        //format xAxis
        self.yearBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.yearBarChartView.xAxis.setLabelCount(dates.count, force: true)
        self.yearBarChartView.xAxis.axisMinimum = 0
        self.yearBarChartView.xAxis.granularityEnabled = true
        self.yearBarChartView.xAxis.granularity = 1
        self.yearBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.yearBarChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.yearBarChartView.xAxis.centerAxisLabelsEnabled = true
        
        //format yAxis
        self.yearBarChartView.leftAxis.axisMinimum = 0
        self.yearBarChartView.leftAxis.drawAxisLineEnabled = false
        self.yearBarChartView.leftAxis.drawGridLinesEnabled = false
        self.yearBarChartView.leftAxis.drawLabelsEnabled = false
        self.yearBarChartView.rightAxis.drawLabelsEnabled = false
    }
    
    // sets up the chart data for year view bar chart
    func setChart(dataPoints: [String], values1: [Double], values2: [Double]) {
        self.yearBarChartView.noDataText = "no data provided"
        
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values1[i])
        }
        
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values2[i])
        }
        
        //format bars
        let groupSpace = 0.23
        let barSpace = 0.01
        let barWidth = 0.2
        let yVals1 = (0 ..< dataPoints.count).map(block1)
        let yVals2 = (0 ..< dataPoints.count).map(block2)
        
        let set1: BarChartDataSet = BarChartDataSet(values: yVals1, label: "medications missed")
        
        set1.setColor(UIColor.yellow)
        
        let set2: BarChartDataSet = BarChartDataSet(values: yVals2, label: "exercises missed")
        
        set2.setColor(UIColor.red)
        
        //add both data sets
        var dataSets : [BarChartDataSet] = [BarChartDataSet] ()
        dataSets.append(set1)
        dataSets.append(set2)
        
        let data: BarChartData = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth*2
        data.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        
        //add data to graph
        self.yearBarChartView.data = data
        
    }
}
