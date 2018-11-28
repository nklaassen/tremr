
//
//  LoginViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-22.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {
    
    
    
    //log in page: textfields
    @IBOutlet weak var logInEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Login"
        // Do any additional setup after loading the view.
    }
    
    //log in page: buttons
    @IBAction func logInButton(_ sender: Any) {
        print(logInEmailTextField)
        print(logInPasswordTextField)
        print("pressed log in button")
        
        if true{ //account doesnt exist
            print("Account does not exist")
        }
        else{
            //complete log in
            //segway to main.storyboard
        }
    }
    
    //goes to create account page
    @IBAction func createAccountButton(_ sender: Any) {
        print("pressed create account button")
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
