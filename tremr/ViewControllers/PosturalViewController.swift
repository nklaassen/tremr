//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class PosturalViewController: UIViewController {
    
    var gyroValues = Array<Int>()
    var accelValues = Array<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        motion.addGyroObserver(observer: {(x: Double, y: Double, z: Double) -> Void in
            let summary = Int(abs(x) + abs(y) + abs(z));
            
            self.gyroValues.append(summary)
            
            print(summary);
            if IS_DEBUG { print("Gyro: \(summary)") }
        })
        
        motion.addAccelerometerObserver(observer: {(x: Double, y: Double, z: Double) -> Void in
            let summary = Int(abs(x) + abs(y) + abs(z));
            
            self.accelValues.append(summary)
            
            print(summary);
            if IS_DEBUG { print("Accelerometer: \(summary)") }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            motion.clearObservers()
            
            print("Got \(gyroValues.count) gyroscope values")
            print("Got \(accelValues.count) accelerometer values")
        })

        // Do any additional setup after loading the view.
    }
    
    //-------------------------------GyroScope-------------------------------------------------
    func initAccelGyro() {
        
        
    }

}


