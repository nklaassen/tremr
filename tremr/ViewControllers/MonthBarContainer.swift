//
//  Name of file: MonthBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: copied code from WeekBarContainer.swift and edited it to month
//          2018-11-02: formatted bar graph to look nice
//
// Known Bugs: graph does not take data from the database yet

import Charts
import Foundation
import UIKit

class MonthBarContainer: UIViewController {
    
    @IBOutlet weak var monthBarChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dates = ["Week 1", "Week 2", "Week 3", "Week 4", ""]
        let medication = [1.0, 4.0, 5.0, 7.0, 9.0]
        let exercise = [4.0, 6.0, 3.0, 8.0, 9.0]
        
        setChart(dataPoints: dates, values1: medication, values2: exercise)
        
        //format chart
        self.monthBarChartView.chartDescription?.text = ""
        
        //format xAxis
        self.monthBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.monthBarChartView.xAxis.setLabelCount(dates.count, force: true)
        self.monthBarChartView.xAxis.axisMinimum = 0
        self.monthBarChartView.xAxis.granularityEnabled = true
        self.monthBarChartView.xAxis.granularity = 1
        self.monthBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.monthBarChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.monthBarChartView.xAxis.centerAxisLabelsEnabled = true
        
        //format yAxis
        self.monthBarChartView.leftAxis.axisMinimum = 0
        self.monthBarChartView.leftAxis.drawAxisLineEnabled = false
        self.monthBarChartView.leftAxis.drawGridLinesEnabled = false
        self.monthBarChartView.leftAxis.drawLabelsEnabled = false
        self.monthBarChartView.rightAxis.drawLabelsEnabled = false
    }
    
    // sets up the chart data for month view bar chart
    func setChart(dataPoints: [String], values1: [Double], values2: [Double]) {
        self.monthBarChartView.noDataText = "no data provided"
        
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values1[i])
        }
        
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values2[i])
        }
        
        //format bars
        let groupSpace = 0.3
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
        self.monthBarChartView.data = data
        
    }
}

