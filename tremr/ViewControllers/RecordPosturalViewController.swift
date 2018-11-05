//
//  Name of file: RecordPosturalViewController.swift
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

//Class for recording the Postural Tremor 
class RecordPosturalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableInput()
        Tremr.recordPostural() {
            self.enableInput()
            self.performSegue(withIdentifier: "PosturalDoneRecording", sender: nil)
        }
    }
    
    
    private func disableInput() {

        view.isUserInteractionEnabled = false
    }
    
    private func enableInput() {
       
        view.isUserInteractionEnabled = true
    }
}
