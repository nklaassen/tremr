//
//  DisplaySeverityViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-28.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class DisplaySeverityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        PosturalLabel.text = String(Tremr.GetPosturalScore())
        RestingLabel.text = String(Tremr.GetRestingScore())
    }
    
    @IBOutlet weak var PosturalLabel: UILabel!
    @IBOutlet weak var RestingLabel: UILabel!
}
