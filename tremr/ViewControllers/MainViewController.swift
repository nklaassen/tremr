//
//  Name of file: MainViewController.swift
//  Programmers: Nic Klaassen
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: initial commit
// Known Bugs:

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Main Page View is loaded :)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //To change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0, green: 0.6, blue: 1.0, alpha: 1.0)
        //To change Back button title & icon color
        UINavigationBar.appearance().tintColor = UIColor.white
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

