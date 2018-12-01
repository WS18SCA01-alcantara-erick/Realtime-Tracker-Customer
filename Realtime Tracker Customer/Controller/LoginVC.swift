//
//  LoginVC.swift
//  Realtime Tracker Customer
//
//  Created by bookr on 9/22/18.
//  Copyright © 2018 bookr. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    private let TRACKER_SEGUE = "CustomerVC"

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
    
    if emailTextField.text != "" && passwordTextField.text != "" {
    
    Authprovider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
    
    if message != nil {
        self.alertTheUser(title: "Problem With Authentication", message: message!);
    } else {
        self.performSegue(withIdentifier: self.TRACKER_SEGUE, sender: nil);
    }
    
    });
    
    } else {
    alertTheUser(title:"Email and Password are required.", message: "Please enter valid email and password.");
    }
}
    
    @IBAction func registerButton(_ sender: Any) {
    
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Authprovider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem creating new user.", message: message!);
                } else {
                    self.performSegue(withIdentifier: self.TRACKER_SEGUE, sender: nil);
                }
                
            });
            
        } else {
            alertTheUser(title: "Email and Password are required.", message: "Please enter valid email and password.")
        }
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        _ = UIAlertAction(title: "OK", style: .default
            , handler: nil);
        present(alert, animated: true, completion: nil)
    
    
        func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

}
}
