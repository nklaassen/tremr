//
//  Name of file: InstructionsForTrackingViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-29: Created file and basic functionality
// Known Bugs: N/A

import UIKit

//Class for tracking instructions 
class InstructionsForTrackingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Measurement Instructions"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //Textfield 
    @IBAction func Instructions(_ sender: UITextField) {
        
    }

}
