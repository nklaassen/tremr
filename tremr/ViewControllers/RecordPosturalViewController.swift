//
//  RecordPosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra and Nic Klaassen on 2018-10-28.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

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
