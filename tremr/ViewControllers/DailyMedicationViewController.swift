//
//  DailyMedicationViewController.swift
//  tremr
//
//  Created by Jason Fevang on 10/31/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class DailyMedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var medTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var medications = [Medicine]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load medications into table
        loadMedications()
        
        medTableView.delegate = self
        medTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print("fill table")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MedicationTableViewCell else {
            fatalError("The dequeued cell is not an instance of MedicationTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let med = medications[indexPath.row]
        
        cell.medNameLabel.text = med.name
        cell.medDosageLabel.text = med.dosage
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftArrowButton(_ sender: UIButton) {
        myDate = Calendar.current.date(byAdding: .day, value: -1, to: myDate)!
        dateLabel.text = myDate.toString(dateFormat: "MM-dd-yyyy")
    }
    
    @IBAction func rightArrowButton(_ sender: UIButton) {
        myDate = Calendar.current.date(byAdding: .day, value: 1, to: myDate)!
        dateLabel.text = myDate.toString(dateFormat: "MM-dd-yyyy")
    }
    
    @IBAction func addMedication(_ sender: UIButton) {
        db.addMedicine(UID: 5, name: "advil", dosage: "4 pills", monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, reminder: true, start_date: Date.init(), end_date: Date.init())
        print("I just added a medicine")
        
        //load medications into table
        loadMedications()
    }
    
    //MARK: Private Methods
    
    private func loadMedications() {
        //Retrieve medications to be loaded into the table
        print("medications loaded")
        medications = db.getMedicine()
        for medicine in db.getMedicine() {
            print("\(medicine.UID), \(medicine.MID), \(medicine.name), \(medicine.dosage)")
            print("\(medicine.mo.description)")
        }
        var testMed = Medicine(UID: 5, MID: 4, name: "test1", dosage: "dosage", mo: true, tu: true, we: true, th: true, fr: true, sa: true, su: true, reminder: true, start_date: Date.init(), end_date: Date.init())
        medications.append(testMed)
    }
}
