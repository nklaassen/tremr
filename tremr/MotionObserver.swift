//
//  Name of file: MotionObserver.swift
//  Programmers: Nic Klaassen and Devansh Chopra
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-25: add gyroscope tracking
//          2018-10-25: updates
//          2018-11-04: rename GryoScope -> MotionObserver
// Known Bugs:

import Foundation
import CoreMotion

let Fps60 = 0.016

class MotionObserver {
    
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
        return abs(round(1000 * value)/100)
    }
    
    private func initMotionEvents() {
        if motionManager.isDeviceMotionAvailable == false {
            print("Device Motion not available!")
        }
        motionManager.deviceMotionUpdateInterval = updateInterval
        motionManager.startDeviceMotionUpdates()
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue(), withHandler: { (motionData: CMDeviceMotion?, NSError) -> Void in
            let rotation = motionData!.rotationRate
            let gyro = self.roundDouble(value: rotation.x)
                + self.roundDouble(value: rotation.y)
                + self.roundDouble(value: rotation.z)
            
            let acceleration = motionData!.userAcceleration
            let accel = self.roundDouble(value: acceleration.x)
                + self.roundDouble(value: acceleration.y)
                + self.roundDouble(value: acceleration.z)

            self.notifyMotionObservers(gyro: gyro, accel: accel)
            
            if (NSError != nil){
                print("\(String(describing: NSError))")
            }
        })
    }
}
