//
//  DailyExerciseViewController.swift
//  tremr
//
//  Created by Colin Chan on 11/4/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class DailyExerciseViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var exerTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //Array of exercises displayed by table
    var exercises = [Exercise]()
    
    //Day for which exercises are being displayed
    var displayDay = Date()
    
    //Calendar for comparing dates and performing date arithmetic
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load exercises into table
        loadExercises()
        
        //Set containing class as the delegate and datasource of the table view
        exerTableView.delegate = self
        exerTableView.dataSource = self
    }
    
    //MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExerciseTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DailyExerciseTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExerciseTableViewCell.")
        }
        
        // Fetches the appropriate medication for the data source layout.
        let exer = exercises[indexPath.row]
        
        cell.exerNameLabel.text = exer.name
        cell.exerUnitLabel.text = exer.unit
        
        return cell
    }

    //MARK: Actions
    @IBAction func mainViewTransition(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func leftArrowButton(_ sender: UIButton) {
        incrementDisplayDay(changeValue: -1)
    }
    
    @IBAction func rightArrowButton(_ sender: UIButton) {
        incrementDisplayDay(changeValue: 1)
    }
    
    //MARK: Private Methods
    private func loadExercises() {
        //Retrieve exercises to be loaded into the table
        print("exercises loaded")
        exercises = db.getExerciseDate(date: displayDay)
    }
    
    private func incrementDisplayDay(changeValue : Int) {
        displayDay = Calendar.current.date(byAdding: .day, value: changeValue, to: displayDay)!
        if (calendar.isDateInToday(displayDay)){
            dateLabel.text = "Today"
        }
        else if calendar.isDateInTomorrow(displayDay){
            dateLabel.text = "Tomorrow"
        }
        else if calendar.isDateInYesterday(displayDay){
            dateLabel.text = "Yesterday"
        }
        else {
            dateLabel.text = displayDay.toString(dateFormat: "MM-dd-yyyy")
        }
        
        //Load exercises for updated day
        loadExercises()
        
        //Reload table
        exerTableView.reloadData()
    }
}
