//
//  Name of file: MedicationViewController.swift
//  Programmers: Jason Fevang and Colin Chan
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs:

import UIKit

class MedicationViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var medicineTextField: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    
    @IBOutlet weak var suToggle: ToggleButton!
    @IBOutlet weak var moToggle: ToggleButton!
    @IBOutlet weak var tuToggle: ToggleButton!
    @IBOutlet weak var weToggle: ToggleButton!
    @IBOutlet weak var thToggle: ToggleButton!
    @IBOutlet weak var frToggle: ToggleButton!
    @IBOutlet weak var saToggle: ToggleButton!
    @IBOutlet weak var reminderToggle: ToggleButton!
    @IBOutlet weak var confirmationButton: UIButton!
    
    var edittedMedicine : Medicine? = nil
    
    // Add Medicine Page Variables
    var mondayFlag: Bool = false
    var tuesdayFlag: Bool = false
    var wednesdayFlag: Bool = false
    var thursdayFlag: Bool = false
    var fridayFlag: Bool = false
    var saturdayFlag: Bool = false
    var sundayFlag: Bool = false
    var reminderFlag: Bool = false
    
    
    //MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put query for that day's medications here
        // Do any additional setup after loading the view.
        // Fill in the data fields with data if a medicine is provided, meaning this page was accessed by clicking an existing medication
        if edittedMedicine != nil {
            medicineTextField.text = edittedMedicine?.name
            dosageTextField.text = edittedMedicine?.dosage
            suToggle.activateButton(bool: (edittedMedicine?.su)!)
            moToggle.activateButton(bool: (edittedMedicine?.mo)!)
            tuToggle.activateButton(bool: (edittedMedicine?.tu)!)
            weToggle.activateButton(bool: (edittedMedicine?.we)!)
            thToggle.activateButton(bool: (edittedMedicine?.th)!)
            frToggle.activateButton(bool: (edittedMedicine?.fr)!)
            saToggle.activateButton(bool: (edittedMedicine?.sa)!)
            reminderToggle.activateButton(bool: (edittedMedicine?.reminder)!)
            confirmationButton.setTitle("Update Medicine",for: .normal)
        }
        else {
            confirmationButton.setTitle("Add Medicine",for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    @IBAction func addMedicineButton(_ sender: Any) {
        let medicineName: String = medicineTextField.text!
        let dosageValue: String = dosageTextField.text!
        
        if edittedMedicine != nil {
            db.updateMedicine(
                MIDToUpdate: (edittedMedicine?.MID)!,
                name: "\(medicineName)",
                dosage: "\(dosageValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn)
        }
        else {
            db.addMedicine(
                UID: 1,
                name: "\(medicineName)",
                dosage: "\(dosageValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn,
                start_date: Date(),
                end_date: nil)
        }
    }
    
    /*
    @IBAction func queryMedicineDatabase(_ sender: Any) {
        for medicine in db.getMedicine() {
            print("\(medicine.UID), \(medicine.MID), \(medicine.name), \(medicine.dosage)", "\(medicine.sa.description)","\(medicine.mo.description)", "\(medicine.tu.description)", "\(medicine.we.description)", "\(medicine.th.description)", "\(medicine.fr.description)",  "\(medicine.su.description)", "\(medicine.reminder.description)", "\(medicine.start_date)", "\(String(describing: medicine.end_date))")
        }
    }
    */
    
    @IBAction func mondayButton(_ sender: Any) {
        //mondayFlag = !mondayFlag
    }
    @IBAction func tuesdayButton(_ sender: Any) {
        //tuesdayFlag = !tuesdayFlag
    }
    @IBAction func wednesdayButton(_ sender: Any) {
        //wednesdayFlag = !wednesdayFlag
    }
    @IBAction func thursdayButton(_ sender: Any) {
        //thursdayFlag = !thursdayFlag
    }
    @IBAction func fridayButton(_ sender: Any) {
        //fridayFlag = !fridayFlag
    }
    @IBAction func saturdayButton(_ sender: Any) {
        //saturdayFlag = !saturdayFlag
    }
    @IBAction func sundayButton(_ sender: Any) {
        //sundayFlag = !sundayFlag
    }
    @IBAction func reminderButton(_ sender: Any) {
        //reminderFlag = !reminderFlag
    }
}

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
