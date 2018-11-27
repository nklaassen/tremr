//
//  MainMenuViewController.swift
//  tremr
//
//  Created by Devansh Chopra on 2018-11-24.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    
    
    
    @IBOutlet weak var tr: UILabel!
    
    @IBOutlet weak var Tremr: UILabel!
    @IBOutlet weak var Measure: UIButton!
    @IBOutlet weak var Exer: UIButton!
    @IBOutlet weak var Meds: UIButton!
    @IBOutlet weak var Results: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tremr.textColor = [UIColor redColor];
        
        
        Measure.backgroundColor = UIColor.darkGray
        //Measure.backgroundColor = UIColor(red: 0.0, green: 0.9, blue: 0.4, alpha: 1.0)
        Measure.layer.cornerRadius = Measure.frame.size.width/6
        Measure.layer.masksToBounds = true
        Measure.setTitleColor(UIColor.white, for: .normal)
        Measure.layer.shadowColor = UIColor.darkGray.cgColor
        Measure.layer.shadowRadius = 10
        Measure.layer.shadowOpacity = 0.5
        Measure.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        Exer.backgroundColor = UIColor.darkGray
        Exer.layer.cornerRadius = Exer.frame.size.width/6
        Exer.layer.masksToBounds = true
        Exer.setTitleColor(UIColor.white, for: .normal)
        Exer.layer.shadowColor = UIColor.darkGray.cgColor
        Exer.layer.shadowRadius = 10
        Exer.layer.shadowOpacity = 0.5
        Exer.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        Meds.backgroundColor = UIColor.darkGray
        Meds.layer.cornerRadius = Meds.frame.size.width/6
        Meds.layer.masksToBounds = true
        Meds.setTitleColor(UIColor.white, for: .normal)
        Meds.layer.shadowColor = UIColor.darkGray.cgColor
        Meds.layer.shadowRadius = 10
        Meds.layer.shadowOpacity = 0.5
        Meds.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        Results.backgroundColor = UIColor.darkGray
        Results.layer.cornerRadius = Results.frame.size.width/6
        Results.layer.masksToBounds = true
        Results.setTitleColor(UIColor.white, for: .normal)
        Results.layer.shadowColor = UIColor.darkGray.cgColor
        Results.layer.shadowRadius = 10
        Results.layer.shadowOpacity = 0.5
        Results.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet var SettingsOptions: [UIButton]!
    
    
    
    
    @IBAction func HandleSelection(_ sender: UIButton) {
        SettingsOptions.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations:{button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    
    @IBAction func Tapped(_ sender: UIButton) {
    }
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
