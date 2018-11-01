//
//  MeasureViewController.swift
//  tremr
//
//  Created by nklaasse on 10/22/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit



class MeasureViewController: UIViewController {

    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        motion.addGyroObserver(observer: {(x: Double, y: Double, z: Double) -> Void in
//            let summary = Int(abs(x) + abs(y) + abs(z));
//
//            print(summary);
//            //if IS_DEBUG { print("Gyro: \(summary)") }
//        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//-------------------------------GyroScope-------------------------------------------------
//    func initAccelGyro() {
//
//
//    }
}
    

