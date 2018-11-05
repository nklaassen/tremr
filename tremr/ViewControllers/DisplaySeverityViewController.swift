//
//  Name of file: DisplaySeverityViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs: 

import UIKit

//Class for getting the Tremor Severity Scores and inputting it to the database 
class DisplaySeverityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let postural = Tremr.GetPosturalScore()
        let resting = Tremr.GetRestingScore()
        PosturalLabel.text = String(format: "%.1f", Tremr.GetPosturalScore())
        RestingLabel.text = String(format: "%.1f", Tremr.GetRestingScore())
        db.addTremor(restingSeverity: resting, posturalSeverity: postural)
        
        // debug output
        /*
        for tremor in db.getTremors() {
            print("tremor: resting=\(tremor.restingSeverity), postural=\(tremor.posturalSeverity), date=\(tremor.date)")
        }
         */
    }
    
    @IBOutlet weak var PosturalLabel: UILabel!
    @IBOutlet weak var RestingLabel: UILabel!
}
