//  Name of file: MonthContainer.swift
//  Programmers: Kira Nishi-Beckingham and Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-27: added code to show line graph of postural and resting tremor data
//          2018-10-28: formatted line graph to look nice
//          2018-11-02: added functions to grab data from database
//          2018-11-03: checked serverity values to make sure it's in bounds
//
// Known Bugs: N/A

import Foundation
import UIKit
import Charts

class WeekContainer: UIViewController {

    @IBOutlet weak var weekLineChartView: LineChartView!

    let dates = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //format weekLineChartView
        self.weekLineChartView.noDataText = "No data provided"
    
        let data = setChartData(months: dates)
    
        //set data
        self.weekLineChartView.data = data
    
        //set up view
        self.weekLineChartView.chartDescription?.text = ""
        self.weekLineChartView.fitScreen()
        self.weekLineChartView.legend.textColor = UIColor.black
        self.weekLineChartView.gridBackgroundColor = UIColor.darkGray
        self.weekLineChartView.scaleXEnabled = false
    
        //format x-axis
        self.weekLineChartView.xAxis.labelPosition = .bottom
        
        self.weekLineChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.weekLineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.weekLineChartView.xAxis.setLabelCount(dates.count, force: true)
        self.weekLineChartView.xAxis.granularityEnabled = true
        self.weekLineChartView.xAxis.granularity = 1
    
    
        //format y-axis
        self.weekLineChartView.leftAxis.labelCount = 10-1
        self.weekLineChartView.leftAxis.axisMaximum = 10
        self.weekLineChartView.leftAxis.axisMinimum = 0
        self.weekLineChartView.leftAxis.drawGridLinesEnabled = true
        self.weekLineChartView.rightAxis.enabled = false
    }

    // set up line chart data for week view
    func setChartData(months : [String]) -> LineChartData {
        
        let postural = getPosturalData()
        let resting = getRestingData()
    
        //add "Postural" data to line
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0...postural.count-1 {
            yVals1.append(ChartDataEntry(x: Double(i), y: postural[i]))
        }
    
        //format "Postural" line
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Postural")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5))
        set1.setCircleColor(UIColor.red)
        set1.lineWidth = 2.0
        set1.circleRadius = 3.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
    
        //add "Resting" data to line
        var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0...resting.count-1 {
            yVals2.append(ChartDataEntry(x: Double(i), y: resting[i]))
        }
    
        //format "Resting" line
        let set2: LineChartDataSet = LineChartDataSet(values: yVals2, label: "Resting")
        set2.axisDependency = .left // Line will correlate with left axis values
        set2.setColor(UIColor.yellow.withAlphaComponent(0.5))
        set2.setCircleColor(UIColor.yellow)
        set2.lineWidth = 2.0
        set2.circleRadius = 3.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor.yellow
        set2.highlightColor = UIColor.white
        set2.drawCircleHoleEnabled = true
    
        //create an array to store LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
    
        //pass in dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        return(data)
    }

    // get postural tremor data from the database for the last week
    func getPosturalData() -> [Double] {
        let tremors = db.getTremorsForLastWeek() //grab tremors from database
    
        var monP: Double = 0
        var tueP: Double = 0
        var wedP: Double = 0
        var thuP: Double = 0
        var friP: Double = 0
        var satP: Double = 0
        var sunP: Double = 0
        
        //formatting date information so it displays the weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        for var tremor in tremors {
            
            //make sure tremor values are between 0 and 10
            if tremor.posturalSeverity > 10 {
                tremor.posturalSeverity = 10
            }
            
            if tremor.posturalSeverity < 0 {
                tremor.posturalSeverity = 0
            }

            //converting date data of specific tremor to weekday
            let dayOfWeek = dateFormatter.string(from: tremor.date)
    
            //check which weekday the tremor is in
            if dayOfWeek == "Monday"{
                monP = tremor.posturalSeverity
            }
            if dayOfWeek == "Tuesday"{
                tueP = tremor.posturalSeverity
            }
            if dayOfWeek == "Wednesday"{
                wedP = tremor.posturalSeverity
            }
            if dayOfWeek == "Thursday"{
                thuP = tremor.posturalSeverity
            }
            if dayOfWeek == "Friday"{
                friP = tremor.posturalSeverity
            }
            if dayOfWeek == "Saturday"{
                satP = tremor.posturalSeverity
            }
            if dayOfWeek == "Sunday"{
                sunP = tremor.posturalSeverity
            }
        }
    
        //sets the values for the array used in the graph for weekly view
        let weeklyPostural = [sunP, monP, tueP, wedP, thuP, friP, satP]
        
        return(weeklyPostural)
    }
    
    // get resting tremor data from database for the last week
    func getRestingData() -> [Double] {
        let tremors = db.getTremorsForLastWeek() //grab tremors from database
        
        var monR: Double = -1
        var tueR: Double = -1
        var wedR: Double = -1
        var thuR: Double = -1
        var friR: Double = -1
        var satR: Double = -1
        var sunR: Double = -1
    
        //formatting date information so it displays the weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
    
        for var tremor in tremors {
            //make sure tremor values are between 0 and 10
            if tremor.restingSeverity > 10{
                tremor.restingSeverity = 10
            }
            
            if tremor.restingSeverity < 0{
                tremor.restingSeverity = 0
            }
            //converting date data of specific tremor to weekday
            let dayOfWeek = dateFormatter.string(from: tremor.date)
    
            //check which weekday the tremor is in
            if dayOfWeek == "Monday"{
                monR = tremor.restingSeverity
            }
            if dayOfWeek == "Tuesday"{
                tueR = tremor.restingSeverity
            }
            if dayOfWeek == "Wednesday"{
                wedR = tremor.restingSeverity
            }
            if dayOfWeek == "Thursday"{
                thuR = tremor.restingSeverity
            }
            if dayOfWeek == "Friday"{
                friR = tremor.restingSeverity
            }
            if dayOfWeek == "Saturday"{
                satR = tremor.restingSeverity
            }
            if dayOfWeek == "Sunday"{
                sunR = tremor.restingSeverity
            }
        }
    
        //sets the values for the array used in the graph for weekly view
        let weeklyResting = [sunR, monR, tueR, wedR, thuR, friR, satR]
        
        return(weeklyResting)
    }

}

