//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra and Nic Klaasen on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

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



