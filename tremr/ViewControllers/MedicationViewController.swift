//
//  MedicationViewController.swift
//  tremr
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class MedicationViewController: UIViewController {

    // Add Medicine Page Variables
    var mondayFlag: Bool = false
    var tuesdayFlag: Bool = false
    var wednesdayFlag: Bool = false
    var thursdayFlag: Bool = false
    var fridayFlag: Bool = false
    var saturdayFlag: Bool = false
    var sundayFlag: Bool = false
    var reminderFlag: Bool = false
    
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var medicineTextField: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    
    @IBAction func addMedicineButton(_ sender: Any) {
        let medicineName: String = medicineTextField.text!
        let dosageValue: String = dosageTextField.text!
        
        // Need to determine UID to insert in subsequent versions
        db.addMedicine(UID: 1, name: "\(medicineName)", dosage: "\(dosageValue)", monday: mondayFlag, tuesday: tuesdayFlag, wednesday: wednesdayFlag, thursday: thursdayFlag, friday: fridayFlag, saturday: saturdayFlag, sunday: sundayFlag, reminder: reminderFlag, start_date: myDate, end_date: Date.init())
    }
    
    @IBAction func queryMedicineDatabase(_ sender: Any) {
        for medicine in db.getMedicine() {
            print("\(medicine.UID), \(medicine.MID), \(medicine.name), \(medicine.dosage)", "\(medicine.sa.description)","\(medicine.mo.description)", "\(medicine.tu.description)", "\(medicine.we.description)", "\(medicine.th.description)", "\(medicine.fr.description)",  "\(medicine.su.description)", "\(medicine.reminder.description)", "\(medicine.start_date)", "\(String(describing: medicine.end_date))")
        }
    }
    
    @IBAction func mondayButton(_ sender: Any) {
        mondayFlag = !mondayFlag
    }
    @IBAction func tuesdayButton(_ sender: Any) {
        tuesdayFlag = !tuesdayFlag
    }
    @IBAction func wednesdayButton(_ sender: Any) {
        wednesdayFlag = !wednesdayFlag
    }
    @IBAction func thursdayButton(_ sender: Any) {
        thursdayFlag = !thursdayFlag
    }
    @IBAction func fridayButton(_ sender: Any) {
        fridayFlag = !fridayFlag
    }
    @IBAction func saturdayButton(_ sender: Any) {
        saturdayFlag = !saturdayFlag
    }
    @IBAction func sundayButton(_ sender: Any) {
        sundayFlag = !sundayFlag
    }
    @IBAction func reminderButton(_ sender: Any) {
        reminderFlag = !reminderFlag
    }
    
    @IBAction func prevDateButton(_ sender: Any) {
        myDate = Calendar.current.date(byAdding: .day, value: -1, to: myDate)!
        dateLabel.text = myDate.toString(dateFormat: "MM-dd-yyyy")
    }
    
    @IBAction func nextDateButton(_ sender: Any) {
        myDate = Calendar.current.date(byAdding: .day, value: 1, to: myDate)!
        dateLabel.text = myDate.toString(dateFormat: "MM-dd-yyyy")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put query for that day's medications here
        // Do any additional setup after loading the view.
        myDate = Date.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
