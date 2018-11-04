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
    
    //Array of medications displayed by table
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
        
        return cell
    }
    
    //MARK: Actions
    
    //MARK: Private methods
    private func loadExercises() {
        //Retrieve exercises to be loaded into the table
        print("exercises loaded")
        //Get all exercises
        exercises = db.getExercise()
    }
}

