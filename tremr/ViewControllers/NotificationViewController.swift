//
//  NotificationViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-14.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBAction func backButton(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
