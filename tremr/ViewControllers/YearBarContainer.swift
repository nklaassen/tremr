//
//  Name of file: YearBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: copied code from WeekBarContainer.swift and edited it to year
//          2018-11-02: formatted bar graph to look nice
//
// Known Bugs: graph does not take data from the database yet

import Charts
import Foundation
import UIKit

class YearBarContainer: UIViewController {
    
    @IBOutlet weak var yearBarChartView: BarChartView!
    
    let dates1 = ["Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", " "]
    let dates2 = ["Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", " "]
    let dates3 = ["Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", " "]
    let dates4 = ["May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", " "]
    let dates5 = ["Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", " "]
    let dates6 = ["Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", " "]
    let dates7 = ["Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", " "]
    let dates8 = ["Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", " "]
    let dates9 = ["Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", " "]
    let dates10 = ["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", " "]
    let dates11 = ["Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", " "]
    let dates12 = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", " "]
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let medication = [9.0, 4.0, 5.0, 7.0, 9.0, 20.0, 13.0, 2.0, 8.0, 7.0, 17.0, 11.0, 22]
        let exercise = [4.0, 6.0, 3.0, 8.0, 9.0, 15.0, 13.0, 5.0, 8.0, 16.0, 21.0, 14.0, 22]
            
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let currentMonth = dateFormatter.string(from: now)
            
        var startNum = 0;
        var dates = dates1
            
        // select the correct x-axis depending on current month
        if currentMonth == "January"
        {
            dates = dates1
            startNum = 0
        }
        if currentMonth == "February"
        {
            dates = dates2
            startNum = 1
        }
        if currentMonth == "March"
        {
            dates = dates3
            startNum = 2
        }
        if currentMonth == "April"
        {
            dates = dates4
            startNum = 3
        }
        if currentMonth == "May"
        {
            dates = dates5
            startNum = 4
        }
        if currentMonth == "June"
        {
            dates = dates6
            startNum = 5
        }
        if currentMonth == "July"
        {
            dates = dates7
            startNum = 6
        }
        if currentMonth == "August"
        {
            dates = dates8
            startNum = 7
        }
        if currentMonth == "September"
        {
            dates = dates9
            startNum = 8
        }
        if currentMonth == "October"
        {
            dates = dates10
            startNum = 9
        }
        if currentMonth == "November"
        {
            dates = dates11
            startNum = 10
        }
        if currentMonth == "December"
        {
            dates = dates12
            startNum = 11
        }
        
        setChart(dataPoints: dates, values1: medication, values2: exercise, initial: startNum)
        
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
    func setChart(dataPoints: [String], values1: [Double], values2: [Double], initial: Int) {
        self.yearBarChartView.noDataText = "no data provided"
        
        var ii = 0
        
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            ii += 1
            return BarChartDataEntry(x: Double(ii-1), y: values1[i])
        }
        
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            ii += 1
            return BarChartDataEntry(x: Double(i), y: values2[i])
        }
        
        //format bars
        let groupSpace = 0.22
        let barSpace = 0.01
        let barWidth = 0.2
        
        //set the yValues for the first set of values
        var tempYVals = (initial ..< dataPoints.count).map(block1)
        var yVals1 = tempYVals
        tempYVals = (0 ..< initial).map(block1)
        yVals1.append(contentsOf: tempYVals)
        
        //set the yValues for the second set of values
        ii = 0
        tempYVals = (initial ..< dataPoints.count).map(block2)
        var yVals2 = tempYVals
        tempYVals = (0 ..< initial).map(block2)
        yVals2.append(contentsOf: tempYVals)
        
        let set1: BarChartDataSet = BarChartDataSet(values: yVals1, label: "medications missed")
        
        set1.setColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
        
        let set2: BarChartDataSet = BarChartDataSet(values: yVals2, label: "exercises missed")
        
        set2.setColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
        
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
