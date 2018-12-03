//
//  Name of file: AllMedicationViewController.swift
//  Programmers: Jason Fevang and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-11-35: UI updates
// Known Bugs:

import UIKit

class AllMedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    @IBOutlet weak var medTableView: UITableView!
    
    //Array of medications displayed by table
    var medications = [Medicine]()
    
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //load medications into table
        loadMedicationsAsync()
        
        //Set containing class as the delegate and datasource of the table view
        medTableView.delegate = self
        medTableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        self.navigationItem.title = "All Medications"
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
        
        //Set the delButton in the cell to refer to deleteButtonClicked when deleteButton is pressed
        cell.delButton.tag = indexPath.row
        cell.delButton.addTarget(self, action: #selector(self.deleteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ShowDetail" {
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
        }
            
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    //MARK: Actions
    //When the delete button is clicked on the table, this function gets called
    @objc func deleteButtonClicked(_ sender: UIButton) {
        //Here sender.tag will give you the tapped checkbox/Button index from the cell

        //Set entry in database to end today
        
        db.updateMedicineEndDateAsync(medToUpdate: medications[sender.tag]) {_ in
            //Update element from array
            self.medications.remove(at: sender.tag)
            
            self.medTableView.reloadData()
        }

        //Delete row from table section 0
        //medTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        

    }

    
    //MARK: Private methods
    private func loadMedicationsAsync() {
        //Retrieve medications to be loaded into the table
        db.getMedicineAsync() { meds in
            self.medications = meds
            
            self.medTableView.reloadData()
        }
    }
}
