//
//  MeasureViewController.swift
//  tremr
//
//  Created by Nic Klaasen and Devansh Chopra on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit



class MeasureViewController: UIViewController {

    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
    

