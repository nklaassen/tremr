//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra and Nic Klaassen on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import Foundation

class TremorController {
    
    private var gyroValues = Array<(Double)>()
    private var accelValues = Array<(Double)>()
    let recordingTime = 3 // seconds
    private var resting = 0.0
    private var postural = 0.0

    init() {
        // Do any additional setup after loading the view.
    }

    func recordResting(callback: @escaping ()->()) {
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(recordingTime), execute: {
            self.stopRecording()
            self.resting = self.computeSeverity()
            self.gyroValues = []
            self.accelValues = []
            callback()
        })
    }

    func recordPostural(callback: @escaping ()->()) {
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(recordingTime), execute: {
            self.stopRecording()
            self.postural = self.computeSeverity()
            self.gyroValues = []
            self.accelValues = []
            callback()
        })
    }

    func GetRestingScore() -> Double {
        return resting
    }
    
    func GetPosturalScore() -> Double {
        return postural
    }
    
    private func startRecording() {
        motion.addMotionObserver(observer: {(gyro: Double, accel: Double) -> Void in
            self.gyroValues.append(gyro)
            self.accelValues.append(accel)
        })
    }
    
    private func stopRecording() {
        motion.clearObservers()
    }
    
    private func computeSeverity() -> Double {
        var severity = 0.0
        // don't crash if we don't get any values (eg in the simulator)
        if (gyroValues.count > 2) {
            
            var sum = 0.0
           
            for i in 0...gyroValues.count-2 {
                sum += abs(gyroValues[i+1] - gyroValues[i])
            }
            
            for i in 0...accelValues.count-2 {
                sum += abs(self.accelValues[i+1] - accelValues[i])
            }
            
            severity = 1.8 * log2((sum)/Double(accelValues.count-1)+1)
            
            if (severity > 10){
                severity = 10
            }
        }
        
        print("severity: \(severity)")
        return severity
    }
    
}


