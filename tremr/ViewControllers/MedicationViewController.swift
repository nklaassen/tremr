//
//  MedicationViewController.swift
//  tremr
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class MedicationViewController: UIViewController {

    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet weak var medicineTextField: UITextField!
    @IBOutlet weak var dosageTextField: UITextField!
    
    @IBAction func addMedicineButton(_ sender: Any) {
        let medicineName: String = medicineTextField.text!
        let dosageValue: String = dosageTextField.text!
        
        // Need to determine UID to insert in subsequent versions
        db.addMedicine(UID: 1, name: "\(medicineName)", dosage: "\(dosageValue)", monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false, reminder: true, start_date: Date.init(), end_date: Date.init())
    }
    
    
    
    /*
    @IBAction func queryMedicineDatabase(_ sender: Any) {
        for medicine in db.getMedicine() {
            print("\(medicine.UID), \(medicine.MID), \(medicine.name), \(medicine.dosage)")
            print("\(medicine.monday.description)")
            
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put query for that day's medications here
        // Do any additional setup after loading the view.
        
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

extension UIViewController : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
