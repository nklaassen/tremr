//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class PosturalViewController: UIViewController {
    
    var motionValues = Array<(Double, Double)>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        motion.addMotionObserver(observer: {(gyro: Double, accel: Double) -> Void in
            
            self.motionValues.append((gyro, accel))

            if IS_DEBUG { print("Motion: \((gyro, accel))") }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            motion.clearObservers()
            
            print("Got \(self.motionValues.count) motion values")
        })

        // Do any additional setup after loading the view.
    }
    
    //-------------------------------GyroScope-------------------------------------------------
    func initAccelGyro() {
        
        
    }

}


