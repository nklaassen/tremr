//
//  createAccountViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-25.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//

import UIKit

import Alamofire

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
        
        let name: String = createAccountFullNameTextField.text!
        let email: String = createAccountEmailTextField.text!
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
        else if password1 == "" || name == "" || email == "" {
            print("some fields are empty")
            
            let alert = UIAlertController(title: "", message: "name, email, password fields must not be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
            
            self.present(alert, animated: true, completion: nil)
        }
        else{
            print("passwords match")
            
            //creats account
            //segways to main.storyboard
            let parameters: [String: Any] = [
                "name" : name,
                "email" : email,
                "password" : password1
            ]
            
            Alamofire.request(baseUrl + "auth/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseString() { response in
                    let statusCode = response.response?.statusCode
                    if statusCode == 200 {
                        print("Signup Successful")
                        self.performSegue(withIdentifier: "CreateAccountSegue", sender: nil)
                    } else {
                        print(response.result.value as Any)
                        let alert = UIAlertController(title: "", message: response.result.value, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
                        self.present(alert, animated: true, completion: nil)
                    }
            }
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
