//
//  Name of file: DisplaySeverityViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: show real score
//          2018-10-30: cosmetic updates
//          2018-11-15: UI updates
// Known Bugs: N/A

import UIKit

//Class for getting the Tremor Severity Scores and inputting it to the database 
class DisplaySeverityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let postural = Tremr.GetPosturalScore()
        let resting = Tremr.GetRestingScore()
        posturalLabel.text = String(format: "%.1f", Tremr.GetPosturalScore())
        restingLabel.text = String(format: "%.1f", Tremr.GetRestingScore())
        db.addTremorAsync(restingSeverity: resting, posturalSeverity: postural) {_ in}
        
        // debug output
        /*
        for tremor in db.getTremors() {
            print("tremor: resting=\(tremor.restingSeverity), postural=\(tremor.posturalSeverity), date=\(tremor.date)")
        }
         */
        
        //navigation bar formatting
        self.navigationController?.isNavigationBarHidden = true
    }
    //Buttons and labels 
    @IBOutlet weak var posturalLabel: UILabel!
    @IBOutlet weak var restingLabel: UILabel!
}
