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

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var exerMedTableView: UITableView!
    
    @IBOutlet weak var reminderButton: ToggleButton!
    
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
    
    //Header titles
    var headerTitles = ["Medications", "Exercises"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar formatting
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Notifications"
        
        //Set containing class as the delegate and datasource of the table view
        exerMedTableView.delegate = self
        exerMedTableView.dataSource = self
        
        //load data into array for table
        loadExerMed()

    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return medications.count
        }
        else if section == 1 {
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
        
        if indexPath.section == 0 { //medication
            nameText = medications[indexPath.row].name
            bellIsOn = medications[indexPath.row].reminder
        }
        else if indexPath.section == 1 { //exercise
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
        let onBellImage = UIImage(named: "Bell-On")
        let offBellImage = UIImage(named: "Bell-Off")
        
        //Set name label
        cell.nameLabel.text = nameText
        
        //Set bell image
        if bellIsOn {
            cell.bellImage.image = onBellImage
        }
        else {
            cell.bellImage.image = offBellImage
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
        //Get all active exercises
        exercises = db.getExercise()
        //Get all active medications
        medications = db.getMedicine()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
