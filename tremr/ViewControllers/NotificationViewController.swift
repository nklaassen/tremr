//
//  Name of file: NotificationViewController.swift
//  Programmers: Leo Zhang and Jason FeVang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-11-17: implemented daily notificaitons
//
// Known Bugs:

import UIKit
import UserNotifications

import Alamofire

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var exerMedTableView: UITableView!
    
    @IBOutlet weak var reminderButton: ToggleButton!
    
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func dailyReminderToggle(_ sender: ToggleButton) {
        if reminderButton.isOn{
            let dailyTremorTime = createDate(weekday: 1, hour: 10, minute: 00, year: 2018)
            dailyTremorRecordingReminder(at: dailyTremorTime, ID: "dailyReminder")
        }
        if reminderButton.isOn == false{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
        }
    }
    
    
    //Array of medications displayed by table
    var medications = [Medicine]()
    
    //Array of exercises displayed by table
    var exercises = [Exercise]()
    
    var linkedAccounts = [String]()
    
    //Header titles
    var headerTitles = ["Linked Accounts", "NOTIFICATIONS:", "Medications", "Exercises"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderButton.bringSubview(toFront: textField)
        
        //navigation bar formatting
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Settings"
        
        //Set containing class as the delegate and datasource of the table view
        exerMedTableView.delegate = self
        exerMedTableView.dataSource = self
        
        //load data into array for table
        loadExerMed()
        loadLinkedAccounts()
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //change this for linked accounts
            return linkedAccounts.count
        }
        else if section == 1 {
            return 0
        }
        else if section == 2 {
            return medications.count
        }
        else if section == 3 {
            return exercises.count
        }
        else {
            fatalError("Table section error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        var nameText : String
        var bellIsOn : Bool
        
        if indexPath.section == 0 {
            //change this for linked accounts
            nameText = linkedAccounts[indexPath.row]
            bellIsOn = false
        }
        else if indexPath.section == 1 {
            nameText = "test"
            bellIsOn = false
        }
        else if indexPath.section == 2 { //medication
            nameText = medications[indexPath.row].name
            bellIsOn = medications[indexPath.row].reminder
        }
        else if indexPath.section == 3 { //exercise
            nameText = exercises[indexPath.row].name
            bellIsOn = exercises[indexPath.row].reminder
        }
        else {
            fatalError("Table section error")
        }
        
        let cellIdentifier = "exerMedTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? notificationTableViewCell else {
            fatalError("The dequeued cell is not an instance of notificationTableViewCell.")
        }
        
        //Load images from assets into variables
        //var onBellImage = UIImage(named: "Bell-On")
        //var offBellImage = UIImage(named: "Bell-Off")
        
        //Set name label and bell start state
        cell.nameLabel.text = nameText
        cell.bellButton.initBellState(setOn: bellIsOn)
        //Set the bellButton in the cell to refer to deleteButtonClicked when deleteButton is pressed
        //Encode the section and the path row as an even or odd number. If the number is even, section = 0, row = tag/2. If the number is odd, section = 1, row = (tag-1)/2
        cell.bellButton.tag = 4*indexPath.row + indexPath.section
        cell.bellButton.addTarget(self, action: #selector(self.bellButtonClicked), for: .touchUpInside)
        
        // hide bell button for linked accounts section
        if indexPath.section == 0 {
            cell.bellButton.isHidden = true
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        
        return nil
    }
    
    //MARK: Actions
    @IBAction func backButton(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    //MARK: Private functions
    //Retrieve exercises and medications to be loaded into the table
    func loadExerMed() {
        let group = DispatchGroup()//used to coordinate refreshing table when all exercises and meds are loaded
        
        //Get all active exercises
        group.enter()
        db.getExerciseAsync(){ exers in
            self.exercises = exers
            group.leave()
        }
        
        //Get all active medications
        group.enter()
        db.getMedicineAsync() { meds in
            self.medications = meds
            group.leave()
        }
        
        //Run this notify code when group.enter() matches group.leave()
        group.notify(queue: .main) {
            self.exerMedTableView.reloadData()
        }
    }
    
    func loadLinkedAccounts() {
        let token = UserDefaults.standard.string(forKey: authTokenKey)!
        let authHeader : HTTPHeaders = ["Authorization": token]
        
        Alamofire.request(baseUrl + "users/links/out", method: .get, headers: authHeader)
            .responseJSON() { response in
            print(response)
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    print("successfully got linked accounts")
                default:
                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            if let result = response.result.value {
                let linkedAccounts = result as! NSArray
                print(linkedAccounts)
                for item in linkedAccounts {
                    let linkedAccount = item as? NSDictionary
                    let email = linkedAccount?.object(forKey: "email") as? String
                    if email != nil {
                        self.linkedAccounts.append(email!)
                    }
                }
                
                self.exerMedTableView?.reloadData()
            }
        }
    }
    
    // MARK: Private Methods
    @objc func bellButtonClicked(_ sender: UIButton) {
        //Here sender.tag will give you the tapped checkbox/Button index from the cell
        if (sender.tag - 2) % 2 == 0 { //Medication
            var med = medications[(sender.tag-2)/4]
            print(med.name)
            med.reminder = !med.reminder //Toggle med reminder
            db.updateMedicineAsync(medToUpdate: med){ _ in
                
            }
            
            //do notification stuff here
            let repeatingMonDate = createDate(weekday: 2, hour: 10, minute: 00 , year: 2018)
            var notificationID = "Mo\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingMonDate, name: med.name, ID: notificationID)
            
            let repeatingTueDate = createDate(weekday: 3, hour: 10, minute: 00 , year: 2018)
            notificationID = "Tu\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingTueDate, name: med.name, ID: notificationID)
            
            let repeatingWedDate = createDate(weekday: 4, hour: 10, minute: 00 , year: 2018)
            notificationID = "We\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingWedDate, name: med.name, ID: notificationID)
            
            let repeatingThuDate = createDate(weekday: 5, hour: 10, minute: 00 , year: 2018)
            notificationID = "Th\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingThuDate, name: med.name, ID: notificationID)
            
            let repeatingFriDate = createDate(weekday: 6, hour: 10, minute: 00 , year: 2018)
            notificationID = "Fr\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingFriDate, name: med.name, ID: notificationID)
            
            let repeatingSatDate = createDate(weekday: 7, hour: 10, minute: 00 , year: 2018)
            notificationID = "Sa\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingSatDate, name: med.name, ID: notificationID)
            
            let repeatingSunDate = createDate(weekday: 1, hour: 10, minute: 00 , year: 2018)
            notificationID = "Su\(med.MID)"
            scheduleMedicationNotificationWeekly(at: repeatingSunDate, name: med.name, ID: notificationID)
        }
        else { //Exercise
            var exer = exercises[(sender.tag-3)/4]
            print(exer.name)
            exer.reminder = !exer.reminder
            db.updateExerciseAsync(exerToUpdate: exer) { _ in
                
            }
            
            //do notification stuff here
            let repeatingMonDate = createDate(weekday: 2, hour: 10, minute: 00 , year: 2018)
            var notificationID = "Mo\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingMonDate, name: exer.name, ID: notificationID)
            
            let repeatingTueDate = createDate(weekday: 3, hour: 10, minute: 00 , year: 2018)
            notificationID = "Tu\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingTueDate, name: exer.name, ID: notificationID)
            
            let repeatingWedDate = createDate(weekday: 4, hour: 10, minute: 00 , year: 2018)
            notificationID = "We\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingWedDate, name: exer.name, ID: notificationID)
            
            let repeatingThuDate = createDate(weekday: 5, hour: 10, minute: 00 , year: 2018)
            notificationID = "Th\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingThuDate, name: exer.name, ID: notificationID)
            
            let repeatingFriDate = createDate(weekday: 6, hour: 10, minute: 00 , year: 2018)
            notificationID = "Fr\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingFriDate, name: exer.name, ID: notificationID)
            
            let repeatingSatDate = createDate(weekday: 7, hour: 10, minute: 00 , year: 2018)
            notificationID = "Sa\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingSatDate, name: exer.name, ID: notificationID)
            
            let repeatingSunDate = createDate(weekday: 1, hour: 10, minute: 00 , year: 2018)
            notificationID = "Su\(exer.EID)"
            scheduleExerciseNotificationWeekly(at: repeatingSunDate, name: exer.name, ID: notificationID)
        }
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Link an Account", message: "Enter an email to link", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Link", style: .default) { (_) in
            
            //getting the input values from user
            let email : String = alertController.textFields?[0].text ?? ""
            print("attempting to link acount \(email)")
            //add email to linked accounts
            let token = UserDefaults.standard.string(forKey: authTokenKey)!
            let headers : HTTPHeaders = ["Authorization": token]
            
            let parameters : [String: Any] = ["email" : email]
            
            Alamofire.request(baseUrl + "users/links/out", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString() { response in
                let statusCode = response.response?.statusCode
                if statusCode == 200 {
                    print("adding linked account Successful")
                    self.loadLinkedAccounts()
                } else {
                    let responseString = response.result.value
                    if responseString != nil {
                        let responseString = responseString!
                        print(responseString)
                        let alert = UIAlertController(title: "", message: responseString, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }

        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Email"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func addLinkedAccount(_ sender: Any) {
        showInputDialog()
    }
}
