//
//  ViewController.swift
//  TeamBlack
//
//  Created by OSU App Center on 11/10/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Declaration of UIObjects
    @IBOutlet weak var loginId: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield delegates
        loginId.delegate = self
        loginPassword.delegate = self
    }
    
    // Login method.
    @IBAction func btnLogin(_ sender: Any) {
        
        let usernameEntered = loginId.text!
        let passwordEntered = loginPassword.text!
        
        // Go to database and set UserVaribles if valid user
        DatabaseHelper.authenticate(usernameEntered, passwordEntered, self)
    }
    
    // called when user is validated
    func goToNextView() {
        performSegue(withIdentifier: "validated", sender: self)
    }
    
    // ensure only valid credentials will perform the segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    // when the keyboard appears the view goesup.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y = -100
    }

    // when the keyboard is dismissed the view comes to normal position.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.frame.origin.y = 0
        loginId.resignFirstResponder()
        loginPassword.resignFirstResponder()

        return true
    }
}

