//
//  ExerciseViewController.swift
//  tremr
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var suToggle: ToggleButton!
    @IBOutlet weak var moToggle: ToggleButton!
    @IBOutlet weak var tuToggle: ToggleButton!
    @IBOutlet weak var weToggle: ToggleButton!
    @IBOutlet weak var thToggle: ToggleButton!
    @IBOutlet weak var frToggle: ToggleButton!
    @IBOutlet weak var saToggle: ToggleButton!
    @IBOutlet weak var reminderToggle: ToggleButton!
    @IBOutlet weak var confirmationButton: UIButton!
    
    var edittedExercise : Exercise? = nil
    
    // Add Exercise Page Variables
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
        // Put query for that day's exercises here
        // Do any additional setup after loading the view.
        // Fill in the data fields with data if a exercise is provided, meaning this page was accessed by clicking an existing exercise
        if edittedExercise != nil {
            exerciseTextField.text = edittedExercise?.name
            unitTextField.text = edittedExercise?.unit
            suToggle.activateButton(bool: (edittedExercise?.su)!)
            moToggle.activateButton(bool: (edittedExercise?.mo)!)
            tuToggle.activateButton(bool: (edittedExercise?.tu)!)
            weToggle.activateButton(bool: (edittedExercise?.we)!)
            thToggle.activateButton(bool: (edittedExercise?.th)!)
            frToggle.activateButton(bool: (edittedExercise?.fr)!)
            saToggle.activateButton(bool: (edittedExercise?.sa)!)
            reminderToggle.activateButton(bool: (edittedExercise?.reminder)!)
            confirmationButton.setTitle("Update Exercise",for: .normal)
        }
        else {
            confirmationButton.setTitle("Add Exercise",for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func addExerciseButton(_ sender: Any) {
        let exerciseName: String = exerciseTextField.text!
        let unitValue: String = unitTextField.text!
        
        if edittedExercise != nil {
            db.updateExercise(
                EIDToUpdate: (edittedExercise?.EID)!,
                name: "\(exerciseName)",
                unit: "\(unitValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn)
        }
        else {
            db.addExercise(
                UID: 1,
                name: "\(exerciseName)",
                unit: "\(unitValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn,
                start_date: Date(),
                end_date: nil)
        }
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
