
//
//  LoginViewController.swift
//  tremr
//
//  Created by Jakub2 on 2018-11-22.
//  Copyright © 2018 CO.DEsign. All rights reserved.
//
import UIKit

import Alamofire



class LoginViewController: UIViewController {
    
    //log in page: textfields
    @IBOutlet weak var logInEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        let tokenOptional = UserDefaults.standard.string(forKey: authTokenKey)
        if tokenOptional != nil {
            // test if we are already logged in, if so skip this page
            self.performSegue(withIdentifier: "toDashboard", sender: nil)
        }
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //log in page: buttons
    @IBAction func logInButton(_ sender: Any) {
        print(logInEmailTextField)
        print(logInPasswordTextField)
        print("pressed log in button")
        
        let email: String = logInEmailTextField.text!
        let password: String = logInPasswordTextField.text!

        let parameters: [String: Any] = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(baseUrl + "auth/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseString() { response in
                let statusCode = response.response?.statusCode
                let responseString = response.result.value!
                if statusCode == 200 {
                    print("Signin Successful")
                    
                    // save jwt to persistent storage
                    let defaults = UserDefaults.standard
                    defaults.set(responseString, forKey: authTokenKey)
                    
                    self.performSegue(withIdentifier: "toDashboard", sender: nil)
                    
                } else {
                    print(responseString)
                    let alert = UIAlertController(title: "", message: responseString, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(action) in}))
                    self.present(alert, animated: true, completion: nil)
                }
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
