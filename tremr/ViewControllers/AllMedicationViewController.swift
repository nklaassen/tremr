//
//  AllMedicationViewController.swift
//  tremr
//
//  Created by Jason Fevang on 2018-11-03.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class AllMedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    @IBOutlet weak var medTableView: UITableView!
    
    //Array of medications displayed by table
    var medications = [Medicine]()
    
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load medications into table
        loadMedications()
        
        //Set containing class as the delegate and datasource of the table view
        medTableView.delegate = self
        medTableView.dataSource = self
        
        // Do any additional setup after loading the view.
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
        let cellIdentifier = "AllMedicationTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AllMedicationTableViewCell else {
            fatalError("The dequeued cell is not an instance of MedicationTableViewCell.")
        }
        
        // Fetches the appropriate medication for the data source layout.
        let med = medications[indexPath.row]
        
        cell.medNameLabel.text = med.name
        cell.dosageLabel.text = med.dosage
        
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if (segue.identifier == "ShowDetail") {
            guard let medicationDetailViewController = segue.destination as? MedicationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMedicineCell = sender as? AllMedicationTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = medTableView.indexPath(for: selectedMedicineCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMedicine = medications[indexPath.row]
            
            //copy over data to detailed view
            medicationDetailViewController.edittedMedicine = selectedMedicine
            
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
    }
    
    //MARK: Actions
    //button clicks here
    
    
    //MARK: Private methods
    private func loadMedications() {
        //Retrieve medications to be loaded into the table
        print("medications loaded")
        //Get all medicine
        medications = db.getMedicine()
    }
}
