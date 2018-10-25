//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class PosturalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        motion.addGyroObserver(observer: {(x: Double, y: Double, z: Double) -> Void in
            let summary = Int(abs(x) + abs(y) + abs(z));
            
            print(summary);
            //if IS_DEBUG { print("Gyro: \(summary)") }
        })

        // Do any additional setup after loading the view.
    }
    
    //-------------------------------GyroScope-------------------------------------------------
    func initAccelGyro() {
        
        
    }

}


