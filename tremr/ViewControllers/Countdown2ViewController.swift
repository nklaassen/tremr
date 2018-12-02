//
//  Name of file: Countdown2ViewController.swift
//  Programmers: Devansh Chopra and Nic Klaassen and Kira Nishi-Beckingham
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-27: Created file and added basic functionality
//          2018-11-04: CountDown timer added 
//          2018-11-28: UI updates
// Known Bugs: N/A

import UIKit

//The following class is for the countdown that starts the recording
class Countdown2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Resting Measurement"
        let emptyView = UIView(frame: .zero)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: emptyView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    let delay = 5 // 5 Second Countdown
    var countdownCompleted = false
    var countingDown = false
    
    // The button is connected to a segue to go to the next page
    // Here I block that segue until the countdown is done, at which point I trigger the segue myself
    // Note: the page that is being segueued to *must* have an identifier in the storyboard or this will crash
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if countdownCompleted {
            return true
        }
        if !countingDown { // make sure the countdown doesn't get triggered multiple times
            countingDown = true
            countDown(time: delay) {
                self.performSegue(withIdentifier: identifier!, sender: nil)
            }
        }
        return false
    }
    
    // this function accepts a callback that will be executed once the countdown is completed
    private func countDown(time: Int, completion: @escaping ()->())
    {
        // make a text label that will cover the entire view, we will update this with the countdown numbers
        let countDownLabel = UILabel()
        countDownLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        countDownLabel.font = UIFont.systemFont(ofSize: 300)
        countDownLabel.textColor = UIColor(red: 0.0, green: 0.49, blue: 0.8, alpha: 1.0)
        countDownLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        
        countDownLabel.textAlignment = .center
        self.view.addSubview(countDownLabel)
        view.bringSubview(toFront: countDownLabel)
        
        countDownLabel.text = String(time)
        
        // have to do this with asyncs rather than sleeping so we don't block to UI thread
        for i in 1...time-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i), execute: {
                UIView.transition(with: countDownLabel,
                                  duration: 0.25,
                                  options: .transitionFlipFromTop,
                                  animations: {countDownLabel.text = String(time - i)} )
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time), execute: {
            // remove the coundown label
            countDownLabel.removeFromSuperview()
            self.countdownCompleted = true
            completion()
        })
    }
    
}
