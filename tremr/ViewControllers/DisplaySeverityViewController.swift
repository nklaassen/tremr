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
        
        PosturalLabel.text = String(Tremr.GetPosturalScore())
        RestingLabel.text = String(Tremr.GetRestingScore())

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var PosturalLabel: UILabel!
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var RestingLabel: UILabel!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
