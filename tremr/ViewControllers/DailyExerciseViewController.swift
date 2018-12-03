//
//  Name of file: DailyExerciseViewController.swift
//  Programmers: Nic Klaassen and Devansh Chopra and Kira Nishi-Beckingham and Leo Zhang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-22: created file
//          2018-11-15: UI updates
//          2018-11-17: tapping exercises in past or present now removes it
// Known Bugs:

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
        loadExercisesAsync()
        
        //Set containing class as the delegate and datasource of the table view
        exerTableView.delegate = self
        exerTableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Exercise"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //load exercises into table
        loadExercisesAsync()
        
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
        
        // Fetches the appropriate exercise for the data source layout.
        let exer = exercises[indexPath.row]
        
        cell.exerNameLabel.text = exer.name
        cell.exerUnitLabel.text = exer.unit
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Fetches the appropriate medication for the data source layout.
        let exer = exercises[indexPath.row]
        print(exer.name)
        
        //todays date at very start
        let todayStart = Calendar.current.startOfDay(for: Date())
        print(todayStart)
        
        //display chart date at very start
        let displayDateStart = Calendar.current.startOfDay(for: displayDay)
        print(displayDateStart)
        
        //if user is on today
        if todayStart == displayDateStart{
            // Add exercise to list of taken exercises
            db.addTakenExercise(EID : exer.EID, date : Date())
            
            //Update element from array
            exercises.remove(at: indexPath.row)
            
            // Reload the exercises
            loadExercisesAsync()
        }
        
        //if user is in the past
        if displayDateStart < todayStart{
            db.addTakenExercise(EID : exer.EID, date : displayDateStart)
            
            //Update element from array
            exercises.remove(at: indexPath.row)
            
            // Reload the exercises
            loadExercisesAsync()
        }
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
    private func loadExercisesAsync() {
        //Retrieve exercises to be loaded into the table
        print("exercises loaded")
        
        db.getExerciseDateAsync(date: displayDay) { exers in
            //Set exercises
            self.exercises = exers
            //reload table
            self.exerTableView.reloadData()
        }

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
        loadExercisesAsync()
    }
}
