//
//  Name of file: WeakBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: added code to show bar graph of missed medications and exercises
//          2018-11-02: fixed errors in code so there were no build errors
//          2018-11-02: formatted bar graph to look nice
//
// Known Bugs: graph does not take data from the database yet

import Charts
import Foundation
import UIKit

class WeekBarContainer: UIViewController {

    @IBOutlet weak var weekBarChartView: BarChartView!

    let dates1 = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun", ""]
    let dates2 = ["Tues", "Wed", "Thurs", "Fri", "Sat", "Sun", "Mon", ""]
    let dates3 = ["Wed", "Thurs", "Fri", "Sat", "Sun", "Mon", "Tues", ""]
    let dates4 = ["Thurs", "Fri", "Sat", "Sun", "Mon", "Tues", "Wed", ""]
    let dates5 = ["Fri", "Sat", "Sun", "Mon", "Tues", "Wed", "Thurs", ""]
    let dates6 = ["Sat", "Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", ""]
    let dates7 = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medication = [1.0, 0.0, 0.0, 1.0, 2.0, 3.0, 0.0, 4.0]
        let exercise = [0.0, 0.0, 3.0, 0.0, 1.0, 1.0, 3.0, 4.0]
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let currentDay = dateFormatter.string(from: now)
        
        var dates = dates1
        
        if currentDay == "Sunday"
        {
            dates = dates1
        }
        if currentDay == "Monday"
        {
            dates = dates2
        }
        if currentDay == "Tuesday"
        {
            dates = dates3
        }
        if currentDay == "Wednesday"
        {
            dates = dates4
        }
        if currentDay == "Thursday"
        {
            dates = dates5
        }
        if currentDay == "Friday"
        {
            dates = dates6
        }
        if currentDay == "Saturday"
        {
            dates = dates7
        }
        
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
        
        set1.setColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
        
        let set2: BarChartDataSet = BarChartDataSet(values: yVals2, label: "exercises missed")
        
        set2.setColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
        
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
    
    func getExerciseData() -> [Double] {
        var missedExercises = db.getTremorsForLastWeek() //grab tremors from database
        var Exercises: [Double] = [0, 0, 0, 0, 0, 0, 0]
        //finds the size of the data array tremors and subtracts one to match the index of  the last element
        var size = missedExercises.count - 1
        var i = 0
        
        let now = Date()
        var now2 = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        var currentDay = dateFormatter.string(from: now)
        
        while size >= 0 && i < Exercises.count
        {
            var day = missedExercises[size].date
            dateFormatter.dateFormat = "EEEE"
            var today = dateFormatter.string(from: day)
            while today == currentDay
            {
                Exercises[i] += 1
                size -= 1
                day = missedExercises[size].date
                dateFormatter.dateFormat = "EEEE"
                today = dateFormatter.string(from: day)
            }
            i += 1
            now2 = Calendar.current.date(byAdding: .day, value: -1, to: now2)!
            dateFormatter.dateFormat = "EEEE"
            currentDay = dateFormatter.string(from: now2)
        }
        
        return(Exercises)
    }

}


