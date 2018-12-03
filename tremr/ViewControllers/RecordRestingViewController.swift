//
//  Name of file: RecordRestingViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-28: Created basic functionality
//          2018-10-30: cosmetic updates
//          2018-11-15: UI updates
// Known Bugs: N/A

import UIKit

//Class for recording the Resting Tremors
class RecordRestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableInput()
        Tremr.recordResting() {
            self.enableInput()
            self.performSegue(withIdentifier: "PromptSegue", sender: nil)
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //Function that disables input
    private func disableInput() {
        view.isUserInteractionEnabled = false
    }
    //Function that enables input
    private func enableInput() {
        view.isUserInteractionEnabled = true
    }
}



