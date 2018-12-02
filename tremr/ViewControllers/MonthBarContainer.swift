//
//  Name of file: MonthBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: copied code from WeekBarContainer.swift and edited it to month
//          2018-11-02: formatted bar graph to look nice
// Known Bugs: graph does not take data from the database yet

import Charts
import Foundation
import UIKit

//Class for viewing the entire month when viewing the bar graph
class MonthBarContainer: UIViewController {
    
    @IBOutlet weak var monthBarChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dates = ["Week 1", "Week 2", "Week 3", "Week 4", ""]
        let medication = getMedicineData()
        let exercise = getExerciseData()
        
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
        self.monthBarChartView.data = data
        
    }
    
    // get missed exercises from the database for the last month
    func getExerciseData() -> [Double] {
        let MissedExercises = db.getMissedExercisesForLastMonth() //get tremors from database
        
        if MissedExercises.count == 0
        {
            return ([0, 0, 0, 0, 0])
        }
        var counter = MissedExercises.count-1
        
        //For Start Date
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone //OR NSTimeZone.localTimeZone()
        
        var numExercises: [Double] = Array(repeating: 0, count: 28)
        var numExCount = 27
        var day = Date()
        day = calendar.startOfDay(for: day)
        var day2 = MissedExercises[counter].date
        var checkDate = calendar.startOfDay(for: day2)
        
        while counter >= 0 && numExCount >= 0
        {
            while checkDate == day
            {
                numExercises[numExCount] += 1
                counter -= 1
                if counter < 0
                {
                    break
                }
                day2 = MissedExercises[counter].date
                checkDate = calendar.startOfDay(for: day2)
            }
            day = calendar.date(byAdding: .day, value: -1, to: day)!
            day = calendar.startOfDay(for: day)
            numExCount -= 1
        }
        
        //calculates the average severity values for each week for postural and resting
        let exercises1 = numExercises[0]+numExercises[1]+numExercises[2]+numExercises[3]+numExercises[4]+numExercises[5]+numExercises[6]
        let exercises2 = numExercises[7]+numExercises[8]+numExercises[9]+numExercises[10]+numExercises[11]+numExercises[12]+numExercises[13]
        let exercises3 = numExercises[14]+numExercises[15]+numExercises[16]+numExercises[17]+numExercises[18]+numExercises[19]+numExercises[20]
        let exercises4 = numExercises[21]+numExercises[22]+numExercises[23]+numExercises[24]+numExercises[25]+numExercises[26]+numExercises[27]
        
        //sets the values for the array used in the graph for yearly view
        let exercises = [exercises1, exercises2, exercises3, exercises4, 0]
        return(exercises)
    }
    
    // get missed exercises from the database for the last month
    func getMedicineData() -> [Double] {
        let MissedMedicines = db.getMissedMedicinesForLastMonth() //get tremors from database
        var counter = MissedMedicines.count-1
        
        if MissedMedicines.count == 0
        {
            return ([0, 0, 0, 0, 0])
        }
        
        //For Start Date
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone //OR NSTimeZone.localTimeZone()
        
        var numMedicines: [Double] = Array(repeating: 0, count: 28)
        var numMedCount = 27
        var day = Date()
        day = calendar.startOfDay(for: day)
        var day2 = MissedMedicines[counter].date
        var checkDate = calendar.startOfDay(for: day2)

        while counter >= 0 && numMedCount >= 0
        {
            while checkDate == day
            {
                numMedicines[numMedCount] += 1
                counter -= 1
                if counter < 0
                {
                    break
                }
                day2 = MissedMedicines[counter].date
                checkDate = calendar.startOfDay(for: day2)
            }
            day = calendar.date(byAdding: .day, value: -1, to: day)!
            day = calendar.startOfDay(for: day)
            numMedCount -= 1
        }
        
        //calculates the average severity values for each week for postural and resting
        let med1 = numMedicines[0]+numMedicines[1]+numMedicines[2]+numMedicines[3]+numMedicines[4]+numMedicines[5]+numMedicines[6]
        let med2 = numMedicines[7]+numMedicines[8]+numMedicines[9]+numMedicines[10]+numMedicines[11]+numMedicines[12]+numMedicines[13]
        let med3 = numMedicines[14]+numMedicines[15]+numMedicines[16]+numMedicines[17]+numMedicines[18]+numMedicines[19]+numMedicines[20]
        let med4 = numMedicines[21]+numMedicines[22]+numMedicines[23]+numMedicines[24]+numMedicines[25]+numMedicines[26]+numMedicines[27]
        
        //sets the values for the array used in the graph for yearly view
        let medicines = [med1, med2, med3, med4, 0]
        return(medicines)
    }
}

