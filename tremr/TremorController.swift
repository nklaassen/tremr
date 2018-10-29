//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import Foundation

class TremorController {
    
    private var GyroValues = Array<(Double)>()
    private var AccelValues = Array<(Double)>()
    let recordingTime = 3 // seconds
    private var resting = 0.0
    private var postural = 0.0

    
    init() {
        // Do any additional setup after loading the view.
    }
    
    func recordResting(completion: @escaping ()->()) {
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(recordingTime), execute: {
            self.stopRecording()
            self.resting = self.computeSeverity()
            completion()
        })
    }
    
    
    func recordPostural(completion: @escaping ()->()) {
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(recordingTime), execute: {
            self.stopRecording()
            self.postural = self.computeSeverity()
            completion()
        })
    }
    
    private func startRecording() {
        motion.addMotionObserver(observer: {(gyro: Double, accel: Double) -> Void in
            self.GyroValues.append(gyro)
            self.AccelValues.append(accel)
            //print(self.motionValues)
            //if IS_DEBUG { print("Motion: \((gyro, accel))") }
        })
    }
    
    private func computeSeverity() -> Double {
        var SubtractedGyroValues = Array<(Double)>()
        var SubtractedAccelValues = Array<(Double)>()
        
        var sum = 0.0
        for i in 0...self.GyroValues.count-2 {
            
            let SubGyroValues = abs(self.GyroValues[i+1] - self.GyroValues[i])
            sum += SubGyroValues
            
            SubtractedGyroValues.append(SubGyroValues)
            
        }
        
        // print(SubtractedGyroValues)
        
        for j in 0...self.AccelValues.count-2 {
            
            let SubAccelValues = abs(self.AccelValues[j+1] - self.AccelValues[j])
            sum += SubAccelValues
            
            SubtractedAccelValues.append(SubAccelValues)
        }
        
        let average = log2((sum)/Double(self.AccelValues.count-1))
        
        print(average)
        return average
    }
    
    
    
    func GetRestingScore()->Double{
        
        return resting
    }
    
    func GetPosturalScore()->Double{
        
        return postural
    }
    
    
    
    
    
    
    private func stopRecording() {
        motion.clearObservers()
        //print("Got \(self.motionValues.count) motion values")
    }
    
}


