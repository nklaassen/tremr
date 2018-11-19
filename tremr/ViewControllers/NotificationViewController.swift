//
//  NotificationViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-14.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var exerMedTableView: UITableView!
    
    //Array of medications displayed by table
    var medications = [Medicine]()
    
    //Array of exercises displayed by table
    var exercises = [Exercise]()
    
    //Header titles
    var headerTitles = ["Medications", "Exercises"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var onBellImage = UIImage(named: "Bell-On")
        var offBellImage = UIImage(named: "Bell-Off")
        
        //Set name label
        cell.nameLabel.text = nameText
        
        //Set the bellButton in the cell to refer to deleteButtonClicked when deleteButton is pressed
        //Encode the section and the path row as an even or odd number. If the number is even, section = 0, row = tag/2. If the number is odd, section = 1, row = (tag-1)/2
        cell.bellButton.tag = 2*indexPath.row + indexPath.section
        cell.bellButton.addTarget(self, action: #selector(self.bellButtonClicked), for: .touchUpInside)

        
        //Set bell image
        if bellIsOn {
            cell.bellButton.setImage(onBellImage, for: UIControlState.normal)
        }
        else {
            cell.bellButton.setImage(offBellImage, for: UIControlState.normal)
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
    
    // MARK: Private Methods
    @objc func bellButtonClicked(_ sender: UIButton) {
        //Here sender.tag will give you the tapped checkbox/Button index from the cell
        var section : Int
        var row : Int
        if sender.tag % 2 == 0 {
            section = 0
            row = sender.tag/2
        }
        else {
            section = 1
            row = (sender.tag - 1)/2
        }
        
        
        //update medication/exercise
        
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
