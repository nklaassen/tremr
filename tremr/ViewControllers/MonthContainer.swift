//
//  MonthContainer.swift
//  tremr
//
//  Created by Kira Nishi Beckingham and Leo Zhang on 2018-11-01.
//  CO.DEsign
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
// This file sets the line chart for month view
//
// changes:
// data is checked to ensure that it is in bounds
//

import Foundation
import UIKit
import Charts

class MonthContainer: UIViewController {

    @IBOutlet weak var monthLineChartView: LineChartView!
    let dates = ["Week 1", "Week 2", "Week 3", "Week 4"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //format monthLineChartView
        self.monthLineChartView.noDataText = "No data provided"
    
        let data2 = setChartData(months: dates)
    
        //set data
        self.monthLineChartView.data = data2
    
        //set up view
        self.monthLineChartView.chartDescription?.text = ""
        self.monthLineChartView.fitScreen()
        self.monthLineChartView.legend.textColor = UIColor.black
        self.monthLineChartView.gridBackgroundColor = UIColor.darkGray
        self.monthLineChartView.scaleXEnabled = false
    
        //format x-axis
        self.monthLineChartView.xAxis.labelPosition = .bottom
        self.monthLineChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.monthLineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.monthLineChartView.xAxis.setLabelCount(dates.count, force: true)
        self.monthLineChartView.xAxis.granularityEnabled = true
        self.monthLineChartView.xAxis.granularity = 1
        self.monthLineChartView.xAxis.drawLimitLinesBehindDataEnabled = true
    
        //format y-axis
        self.monthLineChartView.leftAxis.labelCount = 10-1
        self.monthLineChartView.leftAxis.axisMaximum = 10
        self.monthLineChartView.leftAxis.axisMinimum = 0
        self.monthLineChartView.leftAxis.drawGridLinesEnabled = true
        self.monthLineChartView.rightAxis.enabled = false
    
    }

    // set line chart data for month view
    func setChartData(months : [String]) -> LineChartData {
    
        let postural = getPosturalData()
        let resting = getRestingData()
        
        //add "Postural" data
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
    
        //add "Resting" data
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
    
        //create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
    
        //pass in our dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        return(data)
    }
    
    // get postural tremor data from the database for the last month
    func getPosturalData() -> [Double] {
        var Tremor = db.getTremors() //get tremors from database
        
        //array of 28 elements to hold severity values
        var Postural: [Double] = Array(repeating: 0, count: 28)
        
        //finds the size of the data array tremors and subtracts one to match the index of  the last element
        var size = Tremor.count - 1
        
        //index to start the arrays at the last element
        var index = 27
        
        //copies postural and resting severity values into newly made array from data from database
        while index > -1 && size > -1 {
            
            //make sure tremor values are between 0 and 10
            if Tremor[size].posturalSeverity > 10{
                Tremor[size].posturalSeverity = 10
            }
            
            if Tremor[size].posturalSeverity < 0{
                Tremor[size].posturalSeverity = 0
            }

            Postural[index] = Tremor[size].posturalSeverity
            index = index - 1
            size =  size - 1
        }
        
        //calculates the average severity values for each week for postural and resting
        let weekOnePostural = (Postural[0]+Postural[1]+Postural[2]+Postural[3]+Postural[4]+Postural[5]+Postural[6]) / 7.0
        let weekTwoPostural = (Postural[7]+Postural[8]+Postural[9]+Postural[10]+Postural[11]+Postural[12]+Postural[13]) / 7.0
        let weekThreePostural = (Postural[14]+Postural[15]+Postural[16]+Postural[17]+Postural[18]+Postural[19]+Postural[20]) / 7.0
        let weekFourPostural = (Postural[21]+Postural[22]+Postural[23]+Postural[24]+Postural[25]+Postural[26]+Postural[27]) / 7.0
        
        //sets the values for the array used in the graph for yearly view
        let postural = [weekOnePostural, weekTwoPostural, weekThreePostural, weekFourPostural]
        return(postural)
    }
    
    // get resting tremor data from the database from the last month
    func getRestingData() -> [Double] {
        
        var Tremor = db.getTremors() //get tremors from database
        
        //array of 28 elements to hold severity values
        var Resting: [Double] = Array(repeating: 0, count: 28)
        
        //finds the size of the data array tremors and subtracts one to match the index of the last element
        var size = Tremor.count - 1
        
        //index to start the arrays at the last element
        var index = 27
        
        //copies postural and resting severity values into newly made array from data from database
        while index > -1 && size > -1 {
            
            //make sure tremor values are between 0 and 10
            if Tremor[size].restingSeverity > 10{
                Tremor[size].restingSeverity = 10
            }
            
            if Tremor[size].restingSeverity < 0{
                Tremor[size].restingSeverity = 0
            }

            Resting[index] = Tremor[size].restingSeverity
            index = index - 1
            size =  size - 1
        }
        
        let weekOneResting = (Resting[0]+Resting[1]+Resting[2]+Resting[3]+Resting[4]+Resting[5]+Resting[6]) / 7.0
        let weekTwoResting = (Resting[7]+Resting[8]+Resting[9]+Resting[10]+Resting[11]+Resting[12]+Resting[13]) / 7.0
        let weekThreeResting = (Resting[14]+Resting[15]+Resting[16]+Resting[17]+Resting[18]+Resting[19]+Resting[20]) / 7.0
        let weekFourResting = (Resting[21]+Resting[22]+Resting[23]+Resting[24]+Resting[25]+Resting[26]+Resting[27]) / 7.0
        
        let resting = [weekOneResting, weekTwoResting, weekThreeResting, weekFourResting]
        
        return(resting)
    }


}
