//
//  Name of file: ViewDataViewController.swift
//  Programmers: Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-26: Charts Library added
//          2018-10-27: weekContainer, monthContainer, yearContainer added
//          2018-10-28: segmented control formatted
//          2018-11-02: weekBarContainer, monthBarContainer, yearBarContainer added and formatted with segmeneted control
//          2018-11-03: week view set to default
//          2018-11-25: UI updates
// Known Bugs: week view default is hard coded (defaut is the top most contaienr) 


import Foundation
import UIKit
//import Charts

//Class for viewing the results with the graphs
class ViewDataViewController: UIViewController {
    
    @IBOutlet weak var weekContainer: UIView!
    @IBOutlet weak var monthContainer: UIView!
    @IBOutlet weak var yearContainer: UIView!
    @IBOutlet weak var weekBarContainer: UIView!
    @IBOutlet weak var monthBarContainer: UIView!
    @IBOutlet weak var yearBarContaienr: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var mainView: UIView!
    
    //Function for changing the x-axis 
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            weekContainer.isHidden = false
            weekBarContainer.isHidden = false
            monthContainer.isHidden = true
            monthBarContainer.isHidden = true
            yearContainer.isHidden = true
            yearBarContaienr.isHidden = true
    
        case 1:
            weekContainer.isHidden = true
            weekBarContainer.isHidden = true
            monthContainer.isHidden = false
            monthBarContainer.isHidden = false
            yearContainer.isHidden = true
            yearBarContaienr.isHidden = true
    
        case 2:
            weekContainer.isHidden = true
            weekBarContainer.isHidden = true
            monthContainer.isHidden = true
            monthBarContainer.isHidden = true
            yearContainer.isHidden = false
            yearBarContaienr.isHidden = false
    
        default:
            weekContainer.isHidden = false
            weekBarContainer.isHidden = false
            monthContainer.isHidden = true
            monthBarContainer.isHidden = true
            yearContainer.isHidden = true
            yearBarContaienr.isHidden = true
    
            break;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "View Data"
    
        //set default view to Week View
        mainView.bringSubview(toFront: weekBarContainer)
        mainView.bringSubview(toFront: weekContainer)
    }
    
    // go back to main menu when the back button is pressed
    @IBAction func mainViewTransition(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}
