//
//  MedicationViewController.swift
//  tremr
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class MedicationViewController: UIViewController {

    //MARK: Actions
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func QueryTest(_ sender: UIButton) {
        db.addMedicine(UID: 1, name: "Advil", dosage: "1 pill", frequency: "mon wed", reminder: true, start_date: Date.init(), end_date: Date.init())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put query for that day's medications here
         
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
