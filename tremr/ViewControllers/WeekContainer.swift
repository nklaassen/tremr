//
//  WeekContainer.swift
//  tremr
//
//  Created by Kira Nishi Beckingham and Leo Zhang on 2018-11-01.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
// This file sets the line chart for week view
//

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
        let Tremor = db.getTremors() //grab tremors from database
    
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
    
        // finds the size of the data array tremors and subtracts one to match the index of the last element
        var size: Int = Tremor.count - 1

        //for loop that runs for 7 or array size if less than 7
        for _ in Tremor{
            //converting date data of specific tremor to weekday
            let dayOfWeek = dateFormatter.string(from: Tremor[size].date)
    
            //check which weekday the tremor is in
            if dayOfWeek == "Monday"{
                monP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Tuesday"{
                tueP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Wednesday"{
                wedP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Thursday"{
                thuP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Friday"{
                friP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Saturday"{
                satP = Tremor[size].posturalSeverity
            }
            if dayOfWeek == "Sunday"{
                sunP = Tremor[size].posturalSeverity
            }
            
            if sunP != 0 && monP != 0 && tueP != 0 && wedP != 0 && thuP != 0 && friP != 0 && satP != 0 {
                break
            }
    
            size = size - 1
    
            if size < 0{
                break
            }
        }
    
        //sets the values for the array used in the graph for weekly view
        let weeklyPostural = [sunP, monP, tueP, wedP, thuP, friP, satP]
        
        return(weeklyPostural)
    }
    
    // get resting tremor data from database for the last week
    func getRestingData() -> [Double] {
        let Tremor = db.getTremors() //grab tremors from database
        
        var monR: Double = 0
        var tueR: Double = 0
        var wedR: Double = 0
        var thuR: Double = 0
        var friR: Double = 0
        var satR: Double = 0
        var sunR: Double = 0
    
        //formatting date information so it displays the weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
    
        // finds the size of the data array tremors and subtracts one to match the index of the last element
        var size: Int = Tremor.count - 1
    
        //for loop that runs for 7 or array size if less than 7
        for _ in Tremor{
            //converting date data of specific tremor to weekday
            let dayOfWeek = dateFormatter.string(from: Tremor[size].date)
    
            //check which weekday the tremor is in
            if dayOfWeek == "Monday"{
                monR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Tuesday"{
                tueR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Wednesday"{
                wedR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Thursday"{
                thuR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Friday"{
                friR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Saturday"{
                satR = Tremor[size].restingSeverity
            }
            if dayOfWeek == "Sunday"{
                sunR = Tremor[size].restingSeverity
            }
            
            if sunR != 0 && monR != 0 && tueR != 0 && wedR != 0 && thuR != 0 && friR != 0 && satR != 0 {
                break
            }
    
            size = size - 1
    
            if size < 0{
                break
            }
        }
    
        //sets the values for the array used in the graph for weekly view
        let weeklyResting = [monR, tueR, wedR, thuR, friR, satR, sunR]
        
        return(weeklyResting)
    }

}

