//
//  NotificationToggleButton.swift
//  tremr
//
//  Created by Jason Fevang on 11/19/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
import UIKit

class NotificationToggleButton: UIButton {
    
    var isOn = false
    
    //Load images from assets into variables
    var onBellImage = UIImage(named: "Bell-On")
    var offBellImage = UIImage(named: "Bell-Off")

    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
        initBellState(setOn: false) //default to off if initBellState isn't called by an outside scope again
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
        initBellState(setOn: false) //default to off if initBellState isn't called by an outside scope again
    }
    
    func initBellState(setOn : Bool) {
        //Set bell image
        isOn = setOn
        if isOn {
            self.setImage(onBellImage, for: UIControlState.normal)
        }
        else {
            self.setImage(offBellImage, for: UIControlState.normal)
        }
    }
    
    @objc func buttonPressed() {
        isOn = !isOn
        if isOn {
            self.setImage(onBellImage, for: UIControlState.normal)
        }
        else {
            self.setImage(offBellImage, for: UIControlState.normal)
        }
    }
}
