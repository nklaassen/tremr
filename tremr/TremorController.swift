//
//  Name of file: TremorController.swift
//  Programmers: Nic Klaassen and Devansh Chopra
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: Class created
//          2018-10-22: Refactor
//          2018-10-30: Update tremor calculation
//          2018-11-04: Improve comments
// Known Bugs:

import Foundation

// Class which is responsible for recording accelerometer/gyroscope data and calculating severity results
class TremorController {
    
    private var gyroValues = Array<(Double)>()
    private var accelValues = Array<(Double)>()
    private let recordingTime = 10 // seconds
    private var resting = 0.0
    private var postural = 0.0
    private let motion = MotionObserver()

    // MARK: Public interface
    
    init() {
        // Do any additional setup after loading the view.
    }

    // records the resting tremor, accepts a callback that will be called when the recording completes
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

    // records the postural tremor, accepts a callback that will be called when the recording completes
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
    
    // Mark: Internal methods
    
    private func startRecording() {
        motion.addMotionObserver(observer: {(gyro: Double, accel: Double) -> Void in
            self.gyroValues.append(gyro)
            self.accelValues.append(accel)
            print("gryoscope: \(gyro) accelerometer: \(accel)")
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


