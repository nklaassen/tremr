//
//  Name of file: RecordRestingViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: show real score
//          2018-10-30: cosmetic updates
// Known Bugs: 

import UIKit

//Class for recording the Resting Tremors
class RecordRestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableInput()
        Tremr.recordResting() {
            self.enableInput()
            self.performSegue(withIdentifier: "RestingDoneRecording", sender: nil)
        }
    }
    
    
    private func disableInput() {
        view.isUserInteractionEnabled = false
    }
    
    private func enableInput() {
        view.isUserInteractionEnabled = true
    }
}



