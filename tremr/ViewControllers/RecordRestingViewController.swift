//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class RecordRestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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



