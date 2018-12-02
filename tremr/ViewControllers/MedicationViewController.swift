//
//  Name of file: MedicationViewController.swift
//  Programmers: Jason Fevang and Colin Chan and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-02: Created file and basic functions
//          2018-11-12: notifications added
//          2018-11-25: UI updates 
// Known Bugs: N/A

import UIKit
import UserNotifications

//Class for the Medication view controller
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
            confirmationButton.setTitle("Update Medication",for: .normal)
        }
        else {
            confirmationButton.setTitle("Add Medication",for: .normal)
        }
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        self.navigationItem.title = "Edit/New Medication"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    @IBAction func addMedicineButton(_ sender: Any) {
        let medicineName: String = medicineTextField.text!
        let dosageValue: String = dosageTextField.text!
        var MID : Int64
        if edittedMedicine != nil {
            db.updateMedicine(
                MIDToUpdate: (edittedMedicine?.MID)!,
                name: "\(medicineName)",
                dosage: "\(dosageValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn)
            MID = edittedMedicine!.MID
        }
        else {
            MID = db.addMedicine(
                UID: 1,
                name: "\(medicineName)",
                dosage: "\(dosageValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn,
                start_date: Date(),
                end_date: nil)!
        }
        
        //notification
        if reminderToggle.isOn {
            if moToggle.isOn {
                let repeatingMonDate = createDate(weekday: 2, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Mo\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingMonDate, name: medicineName, ID: notificationID)
            }
            if moToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Mo\(MID)"])
            }
            if tuToggle.isOn {
                let repeatingTueDate = createDate(weekday: 3, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Tu\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingTueDate, name: medicineName, ID: notificationID)
            }
            if tuToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Tu\(MID)"])
            }
            if weToggle.isOn {
                let repeatingWedDate = createDate(weekday: 4, hour: 10, minute: 00 , year: 2018)
                let notificationID = "We\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingWedDate, name: medicineName, ID: notificationID)
            }
            if weToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["We\(MID)"])
            }
            if thToggle.isOn {
                let repeatingThuDate = createDate(weekday: 5, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Th\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingThuDate, name: medicineName, ID: notificationID)
            }
            if thToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Th\(MID)"])
            }
            if frToggle.isOn {
                let repeatingFriDate = createDate(weekday: 6, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Fr\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingFriDate, name: medicineName, ID: notificationID)
            }
            if frToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Fr\(MID)"])
            }
            if saToggle.isOn {
                let repeatingSatDate = createDate(weekday: 7, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Sa\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingSatDate, name: medicineName, ID: notificationID)
            }
            if saToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Sa\(MID)"])
            }
            if suToggle.isOn {
                let repeatingSunDate = createDate(weekday: 1, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Su\(MID)"
                scheduleMedicationNotificationWeekly(at: repeatingSunDate, name: medicineName, ID: notificationID)
            }
            if suToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Su\(MID)"])
            }
        }

        self.navigationController?.popViewController(animated: true)

        if reminderToggle.isOn == false{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Mo\(MID)", "Tu\(MID)", "We\(MID)", "Th\(MID)", "Fr\(MID)", "Sa\(MID)", "Su\(MID)"])
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
