//
//  AllExerciseViewController.swift
//  tremr
//
//  Created by Colin Chan on 11/4/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class AllExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var exerTableView: UITableView!
    
    //Array of exercises displayed by table
    var exercises = [Exercise]()
    
    //MARK: UIViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load exercises into table
        loadExercises()
        
        //Set containing class as the delegate and datasource of the table view
        exerTableView.delegate = self
        exerTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cellIdentifier = "AllExerciseTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AllExerciseTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExerciseTableViewCell.")
        }
        
        // Fetches the appropriate exercise for the data source layout.
        let exer = exercises[indexPath.row]
        
        cell.exerNameLabel.text = exer.name
        cell.unitLabel.text = exer.unit
        
        //Set the delButton in the cell to refer to deleteButtonClicked when deleteButton is pressed
        cell.delButton.tag = indexPath.row
        cell.delButton.addTarget(self, action: #selector(self.deleteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "ShowDetail") {
        
            guard let exerciseDetailViewController = segue.destination as? ExerciseViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedExerciseCell = sender as? AllExerciseTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = exerTableView.indexPath(for: selectedExerciseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedExercise = exercises[indexPath.row]
            
            //copy over data to detailed view
            exerciseDetailViewController.edittedExercise = selectedExercise
        }
    }
    
    //MARK: Actions
    //When the delete button is clicked on the table, this function gets called
    @objc func deleteButtonClicked(_ sender: UIButton) {
        //Here sender.tag will give you the tapped checkbox/Button index from the cell
        
        //Set entry in database to end today
        db.updateExerciseEndDate(EIDToUpdate: exercises[sender.tag].EID)
        
        //Update element from array
        exercises.remove(at: sender.tag)
        
        exerTableView.reloadData()
        //Delete row from table section 0
        //medTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)

    }
    
    //MARK: Private methods
    private func loadExercises() {
        //Retrieve exercises to be loaded into the table
        print("exercises loaded")
        //Get all exercises
        exercises = db.getExercise()
    }
}

