//
//  GyroScope.swift
//  tremr
//
//
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import Foundation
import CoreMotion

let Fps60 = 0.016

class MotionObservable {
    
    let motionManager: CMMotionManager
    let updateInterval: Double = Fps60
    
    var motionObservers = [(Double, Double) -> Void]()
    
    // MARK: Public interface
    
    init() {
        motionManager = CMMotionManager()
        initMotionEvents()
    }
    
        func addMotionObserver(observer: @escaping (Double, Double) -> Void) {
          motionObservers.append(observer)
       }
  
    
    func clearObservers() {
        motionObservers.removeAll()
    }
    
    // MARK: Internal methods
    
    private func notifyMotionObservers(gyro: Double, accel: Double) {
        for observer in motionObservers {
            observer(gyro, accel)
        }
    }
    
    private func roundDouble(value: Double) -> Double {
        return round(1000 * value)/100
    }
    
    private func initMotionEvents() {
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdates()
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue(), withHandler: { (motionData: CMDeviceMotion?, NSError) -> Void in
            let rotation = motionData!.rotationRate
            let x = self.roundDouble(value: rotation.x)
            let y = self.roundDouble(value: rotation.y)
            let z = self.roundDouble(value: rotation.z)
            let gyro = abs(x) + abs(y) + abs(z)
            
            let acceleration = motionData!.userAcceleration
            
            let x1 = self.roundDouble(value: acceleration.x)
            let y1 = self.roundDouble(value: acceleration.y)
            let z1 = self.roundDouble(value: acceleration.z)
            let accel = abs(x1) + abs(y1) + abs(z1)
            
            
            
            
            self.notifyMotionObservers(gyro: gyro, accel: accel)
            
            if (NSError != nil){
                print("\(String(describing: NSError))")
            }
        })
        
//        // Accelerometer
//        if motionManager.isAccelerometerAvailable {
//            motionManager.accelerometerUpdateInterval = updateInterval
//            motionManager.startAccelerometerUpdates(to: OperationQueue(), withHandler:{(accelerometerData: CMAccelerometerData?, NSError) -> Void in
//
//                if let acceleration = accelerometerData?.acceleration {
//                    let x = self.roundDouble(value: acceleration.x)
//                    let y = self.roundDouble(value: acceleration.y)
//                    let z = self.roundDouble(value: acceleration.z)
//                    self.notifyAccelerometerObservers(x: x, y: y, z: z)
//                }
//                if(NSError != nil) {
//                    print("\(String(describing: NSError))")
//                }
//            })
//        } else {
//            print("No accelerometer available")
//        }
    }
}
