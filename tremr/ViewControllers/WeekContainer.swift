//
//  Name of file: MonthContainer.swift
//  Programmers: Kira Nishi-Beckingham and Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-27: added code to show line graph of postural and resting tremor data
//          2018-10-28: formatted line graph to look nice
//          2018-11-02: added functions to grab data from database
//          2018-11-03: checked serverity values to make sure it's in bounds
// Known Bugs: N/A

import Foundation
import UIKit
import Charts

//Class for viewing the entire week when viewing the results 
class WeekContainer: UIViewController {

    @IBOutlet weak var weekLineChartView: LineChartView!

    let dates1 = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
    let dates2 = ["Tues", "Wed", "Thurs", "Fri", "Sat", "Sun", "Mon"]
    let dates3 = ["Wed", "Thurs", "Fri", "Sat", "Sun", "Mon", "Tues"]
    let dates4 = ["Thurs", "Fri", "Sat", "Sun", "Mon", "Tues", "Wed"]
    let dates5 = ["Fri", "Sat", "Sun", "Mon", "Tues", "Wed", "Thurs"]
    let dates6 = ["Sat", "Sun", "Mon", "Tues", "Wed", "Thurs", "Fri"]
    let dates7 = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        set1.setColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
        set1.setCircleColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
        set1.lineWidth = 2.0
        set1.circleRadius = 3.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0)
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
        set2.setColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
        set2.setCircleColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
        set2.lineWidth = 2.0
        set2.circleRadius = 3.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0)
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
        var tremors = db.getTremorsForLastWeek() //grab tremors from database
        
        //finds the size of the data array tremors and subtracts one to match the index of  the last element
        var size = tremors.count - 1
        
        //array of 7 elements to hold severity values
        var Postural: [Double] = Array(repeating: 0, count: 7)
        
        //index to start the arrays at the last element
        var index = 6
        
        //makes date variables
        var today = Date()
        var yesterday = Date()
        var checkYes = Date()
        
        //copies postural and resting severity values into newly made array from data from database
        while index > -1 && size > -1 {
            
            //test to make sure severity values are correct on graph
            print("postural:", tremors[size].posturalSeverity)
            
            //make sure tremor values are between 0 and 10
            if tremors[size].posturalSeverity > 10{
                tremors[size].posturalSeverity = 10
            }
            
            if tremors[size].posturalSeverity < 0{
                tremors[size].posturalSeverity = 0
            }
            
            //check previous tremor score date
            if size - 1 >= 0
            {
                //set all dates to start of date to compare
                let day = tremors[size].date
                let day2 = tremors[size-1].date
                today = Calendar.current.startOfDay(for: day)
                checkYes = Calendar.current.startOfDay(for: day2)
                yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            
                //if tremor score is missing take the average of the adjacent scores
                if checkYes != yesterday
                {
                    Postural[index] = (tremors[size-1].posturalSeverity + tremors[size].posturalSeverity)/2
                }
                else
                {
                    Postural[index] = tremors[size].posturalSeverity
                    size =  size - 1
                }
                index = index - 1
            }
            else
            {
                Postural[index] = tremors[size].posturalSeverity
                size =  size - 1
            }
        }
        return(Postural)
    }
    
    // get resting tremor data from database for the last week
    func getRestingData() -> [Double] {
        var tremors = db.getTremorsForLastWeek() //grab tremors from database
        
        //finds the size of the data array tremors and subtracts one to match the index of  the last element
        var size = tremors.count - 1
        
        //array of 7 elements to hold severity values
        var Resting: [Double] = Array(repeating: 0, count: 7)
        
        //index to start the arrays at the last element
        var index = 6
        
        //makes date variables
        var today = Date()
        var yesterday = Date()
        var checkYes = Date()
        
        //copies postural and resting severity values into newly made array from data from database
        while index > -1 && size > -1 {
            
            //test to make sure severity values are correct on graph
            print("resting:", tremors[size].restingSeverity)
            
            //make sure tremor values are between 0 and 10
            if tremors[size].restingSeverity > 10{
                tremors[size].restingSeverity = 10
            }
            
            if tremors[size].restingSeverity < 0{
                tremors[size].restingSeverity = 0
            }
            
            //check previous tremor score date
            if size - 1 >= 0
            {
                //set all dates to start of date to compare
                let day = tremors[size].date
                let day2 = tremors[size-1].date
                today = Calendar.current.startOfDay(for: day)
                checkYes = Calendar.current.startOfDay(for: day2)
                yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
                
                //if tremor score is missing take the average of the adjacent scores
                if checkYes != yesterday
                {
                    Resting[index] = (tremors[size-1].restingSeverity + tremors[size].restingSeverity)/2
                }
                else
                {
                    Resting[index] = tremors[size].restingSeverity
                    size =  size - 1
                }
                index = index - 1
            }
            else
            {
                Resting[index] = tremors[size].restingSeverity
                size =  size - 1
            }
        }
        return(Resting)
    }
    
}

