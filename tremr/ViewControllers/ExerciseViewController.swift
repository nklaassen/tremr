//
//  Name of file: ExerciseViewController.swift

//  Programmers: Jason Fevang and Colin Chan and Kira Nishi-Beckingham

//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: initial commit
//          2018-10-24: build out pages
//          2018-11-35: UI updates
//          2018-11-12: notifications added

// Known Bugs:

import UIKit
import UserNotifications

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
        
        //button colors?
//        if suToggle.isOn {
//            suToggle.setTitleColor(UIColor.black, for: .normal)
//            suToggle.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0)
//        }
//        else {
//            suToggle.setTitleColor(UIColor.white, for: .normal)
//            suToggle.backgroundColor = UIColor(red: 0.1, green: 0.5, blue: 0.8, alpha: 1.0)
//        }
        self.navigationItem.title = "Edit/New Exercise"
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
            edittedExercise?.name = exerciseName
            edittedExercise?.unit = unitValue
            edittedExercise?.mo = moToggle.isOn
            edittedExercise?.tu = tuToggle.isOn
            edittedExercise?.we = weToggle.isOn
            edittedExercise?.th = thToggle.isOn
            edittedExercise?.fr = frToggle.isOn
            edittedExercise?.sa = saToggle.isOn
            edittedExercise?.su = suToggle.isOn
            edittedExercise?.reminder = reminderToggle.isOn
            db.updateExerciseAsync(exerToUpdate: edittedExercise!) {_ in
                //do stuff here
            }
            
            addNotification(EID: edittedExercise!.EID, exerciseName: exerciseName)
        }
        else {
            db.addExerciseAsync(
                name: "\(exerciseName)",
                unit: "\(unitValue)",
                mo: moToggle.isOn, tu: tuToggle.isOn, we: weToggle.isOn, th: thToggle.isOn, fr: frToggle.isOn, sa: saToggle.isOn, su: suToggle.isOn,
                reminder: reminderToggle.isOn,
                start_date: Calendar.current.startOfDay(for: Date()).addingTimeInterval(-1),//the second before the start of the day
                end_date: nil) {addedEid in
                    self.addNotification(EID: addedEid, exerciseName: exerciseName)
            }
        }
    }
    
    private func addNotification(EID: Int64, exerciseName: String) {
        //notification
        if reminderToggle.isOn {
            if moToggle.isOn {
                let repeatingMonDate = createDate(weekday: 2, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Mo\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingMonDate, name: exerciseName, ID: notificationID)
            }
            if moToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Mo\(EID)"])
            }
            if tuToggle.isOn {
                let repeatingTueDate = createDate(weekday: 3, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Tu\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingTueDate, name: exerciseName, ID: notificationID)
            }
            if tuToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Tu\(EID)"])
            }
            if weToggle.isOn {
                let repeatingWedDate = createDate(weekday: 4, hour: 10, minute: 00 , year: 2018)
                let notificationID = "We\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingWedDate, name: exerciseName, ID: notificationID)
            }
            if weToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["We\(EID)"])
            }
            if thToggle.isOn {
                let repeatingThuDate = createDate(weekday: 5, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Th\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingThuDate, name: exerciseName, ID: notificationID)
            }
            if thToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Th\(EID)"])
            }
            if frToggle.isOn {
                let repeatingFriDate = createDate(weekday: 6, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Fr\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingFriDate, name: exerciseName, ID: notificationID)
            }
            if frToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Fr\(EID)"])
            }
            if saToggle.isOn {
                let repeatingSatDate = createDate(weekday: 7, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Sa\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingSatDate, name: exerciseName, ID: notificationID)
            }
            if saToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Sa\(EID)"])
            }
            if suToggle.isOn {
                let repeatingSunDate = createDate(weekday: 1, hour: 10, minute: 00 , year: 2018)
                let notificationID = "Su\(EID)"
                scheduleExerciseNotificationWeekly(at: repeatingSunDate, name: exerciseName, ID: notificationID)
            }
            if suToggle.isOn == false{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Su\(EID)"])
            }
        }
        if reminderToggle.isOn == false{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Mo\(EID)", "Tu\(EID)", "We\(EID)", "Th\(EID)", "Fr\(EID)", "Sa\(EID)", "Su\(EID)"])
        }
        self.navigationController?.popViewController(animated: true)
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
