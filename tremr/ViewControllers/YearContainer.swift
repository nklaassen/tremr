//  Name of file: YearContainer.swift
//  Programmers: Kira Nishi-Beckingham and Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-27: code copied from weekContainer.swift and edited to year
//          2018-10-28: formatted line graph to look nice
//          2018-11-02: added functions to grab data from database
//          2018-11-03: checked serverity values to make sure it's in bounds
//
// Known Bugs: N/A

import Foundation
import UIKit
import Charts

class YearContainer: UIViewController {

    @IBOutlet var yearLineChartView: LineChartView!
    
    let dates1 = ["Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan"]
    let dates2 = ["Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb"]
    let dates3 = ["Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"]
    let dates4 = ["May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr"]
    let dates5 = ["Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May"]
    let dates6 = ["Jul", "Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let dates7 = ["Aug", "Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"]
    let dates8 = ["Sept", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"]
    let dates9 = ["Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept"]
    let dates10 = ["Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct"]
    let dates11 = ["Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov"]
    let dates12 = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        //format monthLineChartView
        self.yearLineChartView.noDataText = "no data provided"
        
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
        
        setChartDataAsync(months: dates, initial: startNum) { data in
            //set data
            self.yearLineChartView.data = data
        }
        

    }
    
    // set the line chart data for year view
    func setChartDataAsync(months : [String], initial : Int, completion: @escaping (LineChartData) -> ()) {
        
        getDataAsync() { postural, resting in
            var ii:Double = 0;
            
            //add "Postural" data
            var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
            for i in initial...postural.count-1 {
                yVals1.append(ChartDataEntry(x: Double(ii), y: postural[i]))
                ii += 1
            }
            for i in 0...initial-1 {
                yVals1.append(ChartDataEntry(x: Double(ii), y: postural[i]))
                ii += 1
            }
            
            //format "Postural" line
            let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Postural")
            set1.axisDependency = .left // Line will correlate with left axis values
            set1.setColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
            set1.setCircleColor(UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0))
            set1.lineWidth = 2.0
            set1.circleRadius = 0.5
            set1.fillAlpha = 65 / 255.0
            set1.fillColor = UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0)
            set1.highlightColor = UIColor.white
            set1.drawCircleHoleEnabled = true
            
            ii = 0;
            
            //add "Resting" data
            var yVals2 : [ChartDataEntry] = [ChartDataEntry]()
            for i in initial...resting.count-1 {
                yVals2.append(ChartDataEntry(x: Double(ii), y: resting[i]))
                ii += 1
            }
            for i in 0...initial-1 {
                yVals2.append(ChartDataEntry(x: Double(ii), y: resting[i]))
                ii += 1
            }
            
            //format "Resting" line
            let set2: LineChartDataSet = LineChartDataSet(values: yVals2, label: "Resting")
            set2.axisDependency = .left // Line will correlate with left axis values
            set2.setColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
            set2.setCircleColor(UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0))
            set2.lineWidth = 2.0
            set2.circleRadius = 0.5
            set2.fillAlpha = 65 / 255.0
            set2.fillColor = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0)
            set2.highlightColor = UIColor.white
            set2.drawCircleHoleEnabled = true
            
            
            //create an array to store our LineChartDataSets
            var dataSets : [LineChartDataSet] = [LineChartDataSet]()
            dataSets.append(set1)
            dataSets.append(set2)
            
            //pass in our dataSets
            let data: LineChartData = LineChartData(dataSets: dataSets)
            data.setValueTextColor(UIColor.white)
            completion(data)
        }
    }
    
    // get postural and resting tremor data from the database for the last year
    func getDataAsync(completion: @escaping ([Double], [Double]) -> ()) {
        db.getTremorsForLastYearAsync() {tremors in
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
            var size: Int = tremors.count - 1
            
            
            //for loop that runs for 365 or array size if less than 365
            for _ in tremors{
                
                //converting date data of specific tremor to month
                let nameOfMonth = dateFormatter.string(from: tremors[size].date)
                
                //check which month the tremor is in
                switch nameOfMonth {
                case "January":
                    janR.append(tremors[size].restingSeverity)
                    janP.append(tremors[size].posturalSeverity)
                case "February":
                    febR.append(tremors[size].restingSeverity)
                    febP.append(tremors[size].restingSeverity)
                case "March":
                    marR.append(tremors[size].restingSeverity)
                    marP.append(tremors[size].restingSeverity)
                case "April":
                    aprR.append(tremors[size].restingSeverity)
                    aprP.append(tremors[size].restingSeverity)
                case "May":
                    mayR.append(tremors[size].restingSeverity)
                    mayP.append(tremors[size].restingSeverity)
                case "June":
                    junR.append(tremors[size].restingSeverity)
                    junP.append(tremors[size].restingSeverity)
                case "July":
                    julR.append(tremors[size].restingSeverity)
                    julP.append(tremors[size].restingSeverity)
                case "August":
                    augR.append(tremors[size].restingSeverity)
                    augP.append(tremors[size].restingSeverity)
                case "September":
                    sepR.append(tremors[size].restingSeverity)
                    sepP.append(tremors[size].restingSeverity)
                case "October":
                    octR.append(tremors[size].restingSeverity)
                    octP.append(tremors[size].restingSeverity)
                case "November":
                    novR.append(tremors[size].restingSeverity)
                    novP.append(tremors[size].restingSeverity)
                default:
                    decR.append(tremors[size].restingSeverity)
                    decP.append(tremors[size].restingSeverity)
                }
                
                //moving the index one element forward
                size = size - 1
                
                //if the array is shorter than 365 and is now empty
                if size < 0{
                    break
                }
            }
            
            //average resting severity value for each month
            //sum up the values and divide by total elements to get average
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
            
            //average postural severity value for each month
            //sum up the values and divide by total elements to get average
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
            let yearlyResting = [averageJanR, averageFebR, averageMarR, averageAprR, averageMayR, averageJunR, averageJulR, averageAugR, averageSepR, averageOctR, averageNovR, averageDecR]
            let yearlyPostural = [averageJanP, averageFebP, averageMarP, averageAprP, averageMayP, averageJunP, averageJulP, averageAugP, averageSepP, averageOctP, averageNovP, averageDecP]

            completion(yearlyResting, yearlyPostural)
        }
    }
}
