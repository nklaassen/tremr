//
//  YearContainer.swift
//  tremr
//
//  Created by Kira Nishi Beckingham and Leo Zhang on 2018-11-01.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
//  This file sets the line chart for year view
//

import Foundation
import UIKit
import Charts

class YearContainer: UIViewController {

    @IBOutlet var yearLineChartView: LineChartView!
    
    let dates = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //format monthLineChartView
        self.yearLineChartView.noDataText = "no data provided"
        let data2 = setChartData(months: dates)
        
        //set data
        self.yearLineChartView.data = data2
        
        //set up view
        self.yearLineChartView.chartDescription?.text = ""
        self.yearLineChartView.fitScreen()
        self.yearLineChartView.legend.textColor = UIColor.black
        self.yearLineChartView.gridBackgroundColor = UIColor.darkGray
        self.yearLineChartView.scaleXEnabled = false
        
        //format x-axis
        self.yearLineChartView.xAxis.labelPosition = .bottom
        self.yearLineChartView.xAxis.avoidFirstLastClippingEnabled = true
        self.yearLineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        self.yearLineChartView.xAxis.setLabelCount(dates.count, force: true)
        self.yearLineChartView.xAxis.granularityEnabled = true
        self.yearLineChartView.xAxis.granularity = 1
        
        
        //format y-axis
        self.yearLineChartView.leftAxis.labelCount = 10-1
        self.yearLineChartView.leftAxis.axisMaximum = 10
        self.yearLineChartView.leftAxis.axisMinimum = 0
        self.yearLineChartView.leftAxis.drawGridLinesEnabled = true
        self.yearLineChartView.rightAxis.enabled = false
    }
    
    // set the line chart data for year view
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
    
    // get resting tremor data from the database for the last year
    func getRestingData() -> [Double] {
    let Tremor = db.getTremors() //grab tremors from database
    
    //create arrays for resting tremors severity value to be stored in for each month
    var janR: [Double] = []
    var febR: [Double] = []
    var marR: [Double] = []
    var aprR: [Double] = []
    var mayR: [Double] = []
    var junR: [Double] = []
    var julR: [Double] = []
    var augR: [Double] = []
    var sepR: [Double] = []
    var octR: [Double] = []
    var novR: [Double] = []
    var decR: [Double] = []
    
    //formatting date information so it displays the month
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    
    // finds the size of the data array tremors and subtracts one to match the index of the last element
    var size: Int = Tremor.count - 1
    
    
    //for loop that runs for 365 or array size if less than 365
    for _ in Tremor{
    
    //converting date data of specific tremor to month
    let nameOfMonth = dateFormatter.string(from: Tremor[size].date)
    
    //check which month the tremor is in
    
    if nameOfMonth == "January" {
    janR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "February" {
    febR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "March" {
    marR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "April" {
    aprR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "May" {
    mayR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "June" {
    junR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "July" {
    julR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "August" {
    augR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "September" {
    sepR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "October" {
    octR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "November" {
    novR.append(Tremor[size].restingSeverity)
    }
    
    if nameOfMonth == "December" {
    decR.append(Tremor[size].restingSeverity)
    }
    
    //moving the index one element forward
    size = size - 1
    
    //if the array is shorter than 365 and is now empty
    if size < 0{
    break
    }
    }
    
    //average severity value for each month
    //sum up the values and divide by total elemtns to get average
    
    var averageJanR = 0.0
    
    for number in janR {
    averageJanR = Double(number) / Double(janR.count) + averageJanR
    }
    
    var averageFebR = 0.0
    
    for number in febR {
    averageFebR = Double(number) / Double(febR.count) + averageFebR
    }
    
    var averageMarR = 0.0
    
    for number in marR {
    averageMarR = Double(number) / Double(marR.count) + averageMarR
    }
    
    var averageAprR = 0.0
    
    for number in aprR {
    averageAprR = Double(number) / Double(aprR.count) + averageAprR
    }
    
    var averageMayR = 0.0
    
    for number in mayR {
    averageMayR = Double(number) / Double(mayR.count) + averageMayR
    }
    
    var averageJunR = 0.0
    
    for number in junR {
    averageJunR = Double(number) / Double(junR.count) + averageJunR
    }
    
    var averageJulR = 0.0
    
    for number in julR {
    averageJulR = Double(number) / Double(julR.count) + averageJulR
    }
    
    var averageAugR = 0.0
    
    for number in augR {
    averageAugR = Double(number) / Double(augR.count) + averageAugR
    }
    
    var averageSepR = 0.0
    
    for number in sepR {
    averageSepR = Double(number) / Double(sepR.count) + averageSepR
    }
    
    var averageOctR = 0.0
    
    for number in octR {
    averageOctR = Double(number) / Double(octR.count) + averageOctR
    }
    
    var averageNovR = 0.0
    
    for number in novR {
    averageNovR = Double(number) / Double(novR.count) + averageNovR
    }
    
    var averageDecR = 0.0
    
    for number in decR {
    averageDecR = Double(number) / Double(decR.count) + averageDecR
    }
    
    //sets the values for the array used in the graph for yearly view
    let yearlyResting = [averageJanR, averageFebR, averageMarR, averageAprR, averageMayR, averageJunR, averageJulR, averageAugR, averageSepR, averageOctR, averageNovR, averageDecR]
        
        return(yearlyResting)
    }
    
    // get postural data from the database for the last year
    func getPosturalData() -> [Double] {
    let Tremor = db.getTremors() //grab tremors from database
    
    //create arrays for postural tremors severity value to be stored in for each month
    var janP: [Double] = []
    var febP: [Double] = []
    var marP: [Double] = []
    var aprP: [Double] = []
    var mayP: [Double] = []
    var junP: [Double] = []
    var julP: [Double] = []
    var augP: [Double] = []
    var sepP: [Double] = []
    var octP: [Double] = []
    var novP: [Double] = []
    var decP: [Double] = []
    
    //formatting date information so it displays the month
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "LLLL"
    
    // finds the size of the data array tremors and subtracts one to match the index of the last element
    var size: Int = Tremor.count - 1
    
    //for loop that runs for 365 or array size if less than 365
    for _ in Tremor{
    
    //converting date data of specific tremor to month
    let nameOfMonth = dateFormatter.string(from: Tremor[size].date)
    
    //check which month the tremor is in
    
    if nameOfMonth == "January" {
    janP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "February" {
    febP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "March" {
    marP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "April" {
    aprP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "May" {
    mayP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "June" {
    junP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "July" {
    julP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "August" {
    augP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "September" {
    sepP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "October" {
    octP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "November" {
    novP.append(Tremor[size].posturalSeverity)
    }
    
    if nameOfMonth == "December" {
    decP.append(Tremor[size].posturalSeverity)
    }
    
    //moving the index one element forward
    size = size - 1
    
    //if the array is shorter than 365 and is now empty
    if size < 0{
    break
    }
    }
    
    //average severity value for each month
    //sum up the values and divide by total elemtns to get average
    
    var averageJanP = 0.0
    
    
    for number in janP {
    averageJanP = Double(number) / Double(janP.count) + averageJanP
    }
    
    
    var averageFebP = 0.0
    
    for number in febP {
    averageFebP = Double(number) / Double(febP.count) + averageFebP
    }
    
    var averageMarP = 0.0
    
    for number in marP {
    averageMarP = Double(number) / Double(marP.count) + averageMarP
    }
    
    var averageAprP = 0.0
    
    for number in aprP {
    averageAprP = Double(number) / Double(aprP.count) + averageAprP
    }
    
    var averageMayP = 0.0
    
    for number in mayP {
    averageMayP = Double(number) / Double(mayP.count) + averageMayP
    }
    
    var averageJunP = 0.0
    
    for number in junP {
    averageJunP = Double(number) / Double(junP.count) + averageJunP
    }
    
    var averageJulP = 0.0
    
    for number in julP {
    averageJulP = Double(number) / Double(julP.count) + averageJulP
    }
    
    var averageAugP = 0.0
    
    for number in augP {
    averageAugP = Double(number) / Double(augP.count) + averageAugP
    }
    
    var averageSepP = 0.0
    
    for number in sepP {
    averageSepP = Double(number) / Double(sepP.count) + averageSepP
    }
    
    var averageOctP = 0.0
    
    
    for number in octP {
    averageOctP = Double(number) / Double(octP.count) + averageOctP
    }
    
    var averageNovP = 0.0
    
    for number in novP {
    averageNovP = Double(number) / Double(novP.count) + averageNovP
    }
    
    var averageDecP = 0.0
    
    for number in decP {
    averageDecP = Double(number) / Double(decP.count) + averageDecP
    }
    
    //sets the values for the array used in the graph for yearly view
    let yearlyPostural = [averageJanP, averageFebP, averageMarP, averageAprP, averageMayP, averageJunP, averageJulP, averageAugP, averageSepP, averageOctP, averageNovP, averageDecP]
        
        return(yearlyPostural)
        
    }


}
