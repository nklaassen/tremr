//
//  ToggleButton.swift
//  tremr
//
//  Created by Colin Chan on 10/26/18.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = frame.size.height/2
        
        setTitle("No", for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        isOn = bool
        
        let color = bool ? UIColor.black : .clear
        let title = bool ? "Yes" : "No"
        let titleColor = bool ? . white : UIColor.black
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }
}
