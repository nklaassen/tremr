//
//  createAccountViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-25.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

class createAccountViewController: UIViewController {

    //self.navigationController?.isNavigationBarHidden = false
    //self.navigationItem.title = "Create Account"
    
    //create account page: textfields
    @IBOutlet weak var createAccountEmailTextField: UITextField!
    @IBOutlet weak var createAccountFullNameTextField: UITextField!
    @IBOutlet weak var createAccountPasswordTextField: UITextField!
    @IBOutlet weak var createAccountConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Create Account"
        // Do any additional setup after loading the view.
    }
    
    //confirm button pressed
    @IBAction func confirmButton(_ sender: Any) {
        print(createAccountEmailTextField)
        print(createAccountFullNameTextField)
        print(createAccountPasswordTextField)
        print(createAccountConfirmPasswordTextField)
        
        print("confirm button pressed")
        
        let password1: String = createAccountPasswordTextField.text!
        let password2: String = createAccountConfirmPasswordTextField.text!
        
        if password1 != password2{
            print(password1)
            print(password2)
            print("passwords do not match")
            
            let alert = UIAlertController(title: "", message: "Passwords do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if password1 == "" || password2 == ""{
            print("passwords are empty")
            
            let alert = UIAlertController(title: "", message: "Password must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
            
            self.present(alert, animated: true, completion: nil)
        }
        else{
            print("passwords match")
            
            //creats account
            //segways to main.storyboard
        }
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
