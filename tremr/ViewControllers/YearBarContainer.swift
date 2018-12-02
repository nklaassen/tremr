//
//  Name of file: YearBarContainer.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: copied code from WeekBarContainer.swift and edited it to year
//          2018-11-02: formatted bar graph to look nice
// Known Bugs: graph does not take data from the database yet

import Charts
import Foundation
import UIKit

//Class for viewing the entire year when viewing the bar graph
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
            
        let medication = getMissedMedications()
        let exercise = getMissedExercises()
            
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
        
        let block1: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values1[i])
        }
        
        let block2: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: values2[i])
        }
        
        //format bars
        let groupSpace = 0.22
        let barSpace = 0.01
        let barWidth = 0.2
        
        let yValExtra = BarChartDataEntry(x: 12.0, y: 0)
        
        //set the yValues for the first set of values
        var tempYVals = (initial ..< dataPoints.count-1).map(block1)
        var yVals1 = tempYVals
        tempYVals = (0 ..< initial).map(block1)
        yVals1.append(contentsOf: tempYVals)
        yVals1.append(yValExtra)
        
        //set the yValues for the second set of values
        tempYVals = (initial ..< dataPoints.count-1).map(block2)
        var yVals2 = tempYVals
        tempYVals = (0 ..< initial).map(block2)
        yVals2.append(contentsOf: tempYVals)
        yVals2.append(yValExtra)
        
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
    
    // get Exercise data from the database for the last year
    func getMissedExercises() -> [Double] {
        var Exercises = db.getMissedExercises() //grab missed exercises from database
        
        //create doubles for number of missed exercises to be stored in for each month
        var janR: Double = 0
        var febR: Double = 0
        var marR: Double = 0
        var aprR: Double = 0
        var mayR: Double = 0
        var junR: Double = 0
        var julR: Double = 0
        var augR: Double = 0
        var sepR: Double = 0
        var octR: Double = 0
        var novR: Double = 0
        var decR: Double = 0
        
        //formatting date information so it displays the month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        // finds the size of the data array exercises and subtracts one to match the index of the last element
        var size: Int = Exercises.count - 1
        
        
        //for loop that runs for 365 or array size if less than 365
        for _ in Exercises{
            
            //converting date data of specific exercise to month
            let nameOfMonth = dateFormatter.string(from: Exercises[size].date)
            
            //check which month the exercise is in
            
            if nameOfMonth == "January" {
                janR += 1
            }
            
            if nameOfMonth == "February" {
                febR += 1
            }
            
            if nameOfMonth == "March" {
                marR += 1
            }
            
            if nameOfMonth == "April" {
                aprR += 1
            }
            
            if nameOfMonth == "May" {
                mayR += 1
            }
            
            if nameOfMonth == "June" {
                junR += 1
            }
            
            if nameOfMonth == "July" {
                julR += 1
            }
            
            if nameOfMonth == "August" {
                augR += 1
            }
            
            if nameOfMonth == "September" {
                sepR += 1
            }
            
            if nameOfMonth == "October" {
                octR += 1
            }
            
            if nameOfMonth == "November" {
                novR += 1
            }
            
            if nameOfMonth == "December" {
                decR += 1
            }
            
            //moving the index one element forward
            size = size - 1
            
            //if the array is shorter than 365 and is now empty
            if size < 0{
                break
            }
        }

        //sets the values for the array used in the graph for yearly view
        let yearlyEx = [janR, febR, marR, aprR, mayR, junR, julR, augR, sepR, octR, novR, decR]
        
        return(yearlyEx)
    }
    
    // get medication data from the database for the last year
    func getMissedMedications() -> [Double] {
        var Medicaitons = db.getMissedMedicines() //grab missed medicines from database
        
        //create doubles for number of missed exercises to be stored in for each month
        var janR: Double = 0
        var febR: Double = 0
        var marR: Double = 0
        var aprR: Double = 0
        var mayR: Double = 0
        var junR: Double = 0
        var julR: Double = 0
        var augR: Double = 0
        var sepR: Double = 0
        var octR: Double = 0
        var novR: Double = 0
        var decR: Double = 0
        
        //formatting date information so it displays the month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        // finds the size of the data array medication and subtracts one to match the index of the last element
        var size: Int = Medicaitons.count - 1
        
        
        //for loop that runs for 365 or array size if less than 365
        for _ in Medicaitons{
            
            //converting date data of specific tremor to month
            let nameOfMonth = dateFormatter.string(from: Medicaitons[size].date)
            
            //check which month the tremor is in
            
            if nameOfMonth == "January" {
                janR += 1
            }
            
            if nameOfMonth == "February" {
                febR += 1
            }
            
            if nameOfMonth == "March" {
                marR += 1
            }
            
            if nameOfMonth == "April" {
                aprR += 1
            }
            
            if nameOfMonth == "May" {
                mayR += 1
            }
            
            if nameOfMonth == "June" {
                junR += 1
            }
            
            if nameOfMonth == "July" {
                julR += 1
            }
            
            if nameOfMonth == "August" {
                augR += 1
            }
            
            if nameOfMonth == "September" {
                sepR += 1
            }
            
            if nameOfMonth == "October" {
                octR += 1
            }
            
            if nameOfMonth == "November" {
                novR += 1
            }
            
            if nameOfMonth == "December" {
                decR += 1
            }
            
            //moving the index one element forward
            size = size - 1
            
            //if the array is shorter than 365 and is now empty
            if size < 0{
                break
            }
        }
        
        //sets the values for the array used in the graph for yearly view
        let yearlyMed = [janR, febR, marR, aprR, mayR, junR, julR, augR, sepR, octR, novR, decR]
        
        return(yearlyMed)
    }
}
