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
        }
    }
    
    @IBOutlet weak var Next: UIButton!
    
    private func disableInput() {
        Next.isEnabled=false
        view.isUserInteractionEnabled = false
    }
    
    private func enableInput() {
        Next.isEnabled=true
        view.isUserInteractionEnabled = true
    }
}



