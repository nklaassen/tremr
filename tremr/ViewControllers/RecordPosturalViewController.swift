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
