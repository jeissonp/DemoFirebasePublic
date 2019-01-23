//
//  ViewController.swift
//  DemoFirebase
//
//  Created by jeisson on 11/25/18.
//  Copyright © 2018 jeisson. All rights reserved.
//

import UIKit
import Firebase

import SCLAlertView

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "showList", sender: nil)                
            }
        }
    }
    
    @IBAction func btnLoginOnClick(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
            let alert = SCLAlertView()
            
            if error != nil {
                alert.showError("Login", subTitle: (error?.localizedDescription)!)
            }
            else {
                alert.showSuccess("Login", subTitle: "Login successful")
            }
        })
    }
    
    
    @IBAction func btnSignUpOnClick(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
            let alert = SCLAlertView()
            
            if error != nil {
                alert.showError("Signup", subTitle: (error?.localizedDescription)!)
            }
            else {
                alert.showSuccess("Signup", subTitle: "Registration successful!")
            }
        })
    }
    


}

