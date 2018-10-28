//
//  PosturalViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-10-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {
    
    private var motionValues = Array<(Double, Double)>()
    let recordingTime = 10 // seconds

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        disableInput()
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(recordingTime), execute: {
            self.stopRecording()
            self.enableInput()
        })
    }
    
    @IBOutlet weak var posturalNextButton: UIButton?
    @IBOutlet weak var restingNextButton: UIButton?
    private func disableInput() {
        if let button = posturalNextButton ?? restingNextButton {
            button.isEnabled = false
        }
        view.isUserInteractionEnabled = false
    }
    private func enableInput() {
        if let button = posturalNextButton ?? restingNextButton {
            button.isEnabled = true
        }
        self.view.isUserInteractionEnabled = true
    }
    
    private func startRecording() {
        motion.addMotionObserver(observer: {(gyro: Double, accel: Double) -> Void in
            self.motionValues.append((gyro, accel))
            if IS_DEBUG { print("Motion: \((gyro, accel))") }
        })
    }
    
    private func stopRecording() {
        motion.clearObservers()
        print("Got \(self.motionValues.count) motion values")
    }

}


