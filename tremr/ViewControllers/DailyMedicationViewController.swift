//
//  Name of file: DailyMedicationViewController.swift
//  Programmers: Jason Fevang and Kira Nishi-Beckingham and Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-17: added tapping medications in the past
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-11-35: UI updates
// Known Bugs:

import UIKit

class DailyMedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var medTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //Array of medications displayed by table
    var medications = [Medicine]()
    
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //Day for which medications are being displayed, initialized to current day
    var displayDay = Date()
    
    //MARK: Initializer
    //init() {
    //    super.init()
        
        //initialize display day to today
    //    displayDay = calendar.startOfDay(for: Date.init())
    //}
    
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load medications into table
        loadMedicationsAsync()
        
        //Set containing class as the delegate and datasource of the table view
        medTableView.delegate = self
        medTableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Medication"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Set containing class as the delegate and datasource of the table view
        medTableView.delegate = self
        medTableView.dataSource = self
        

        //load medications into table
        loadMedicationsAsync()
        
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MedicationTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DailyMedicationTableViewCell else {
            fatalError("The dequeued cell is not an instance of MedicationTableViewCell.")
        }
        
        // Fetches the appropriate medication for the data source layout.
        let med = medications[indexPath.row]
        
        cell.medNameLabel.text = med.name
        cell.medDosageLabel.text = med.dosage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Fetches the appropriate medication for the data source layout.
        let med = medications[indexPath.row]
        print(med.name)
        
        //todays date at very start
        let todayStart = Calendar.current.startOfDay(for: Date())
        print(todayStart)
        
        //display chart date at very start
        let displayDateStart = Calendar.current.startOfDay(for: displayDay)
        print(displayDateStart)
        
        //if user is on today
        if todayStart == displayDateStart{
            //Update element from array
            medications.remove(at: indexPath.row)

            // Add medication to list of taken medications
            db.addTakenMedicine(MID : med.MID, date : Date())
            
            // Reload the medications
            loadMedicationsAsync()
        }
        
        //if user is in the past
        if displayDateStart < todayStart{
            db.addTakenMedicine(MID : med.MID, date : displayDateStart)
            
            //Update element from array
            medications.remove(at: indexPath.row)

        }
    }
    
    
    //MARK: Actions
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftArrowButton(_ sender: UIButton) {
        incrementDisplayDay(changeValue: -1)
    }
    
    @IBAction func rightArrowButton(_ sender: UIButton) {
        incrementDisplayDay(changeValue: 1)
    }
    
    
    
    //MARK: Private Methods
    private func loadMedicationsAsync() {
        //Retrieve medications to be loaded into the table
        print("medications loaded")
        print(displayDay)
        db.getMedicineDateAsync(date: displayDay) { meds in
            //Set medications
            self.medications = meds
            //reload table
            self.medTableView.reloadData()
        }
    }
    
    private func incrementDisplayDay(changeValue : Int) {
        displayDay = Calendar.current.date(byAdding: .day, value: changeValue, to: displayDay)!
        if (calendar.isDateInToday(displayDay)){
            dateLabel.text = "Today"
        }
        else if calendar.isDateInTomorrow(displayDay){
            dateLabel.text = "Tomorrow"
        }
        else if calendar.isDateInYesterday(displayDay){
            dateLabel.text = "Yesterday"
        }
        else {
            dateLabel.text = displayDay.toString(dateFormat: "MM-dd-yyyy")
        }
        
        //Load medications for updated day
        loadMedicationsAsync()
    }
}



extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
