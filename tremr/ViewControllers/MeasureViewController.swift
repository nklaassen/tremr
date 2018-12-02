//
//  Name of file: MeasureViewController.swift
//  Programmers: Nic Klaassen and Devansh Chopra
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: initial commit
//          2018-10-21: Created the basic class 
// Known Bugs: N/A

import UIKit


//Class for the MeasureView Page
class MeasureViewController: UIViewController {
    
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
    

