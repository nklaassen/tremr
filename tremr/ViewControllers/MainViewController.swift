//
//  Name of file: MainViewController.swift
//  Programmers: Nic Klaassen and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: initial commit with navigation bar 
//          2018-11-25: UI updates
// Known Bugs: N/A

import UIKit

//Class for the main view and the navigation bar for the app
class MainViewController: UIViewController {
    
    @IBOutlet weak var Measure: UIButton!
    @IBOutlet weak var Exercise: UIButton!
    @IBOutlet weak var Meds: UIButton!
    @IBOutlet weak var Results: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        Measure.backgroundColor = UIColor.blue
        
        Measure.layer.cornerRadius = Measure.frame.size.width/6
        Measure.layer.masksToBounds = true
        
        Measure.setTitleColor(UIColor.white, for: .normal)
        Measure.layer.shadowColor = UIColor.darkGray.cgColor
        Measure.layer.shadowRadius = 4
        Measure.layer.shadowOpacity = 0.5
        Measure.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        
        
        
        print("Main Page View is loaded :)")

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function for the navifation bar 
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(false, animated:true)
        //To change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0)
        //To change Back button title & icon color
        UINavigationBar.appearance().tintColor = UIColor.white
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

