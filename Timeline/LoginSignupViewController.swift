//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: Properties
    
    enum ViewMode {
        case Login
        case Signup
    }
    
    var mode: ViewMode = .Signup
    
    var fieldsAreValid: Bool {
        switch mode {
        case .Login:
            return !((emailTextField.text!.isEmpty) || (passwordTextField.text!.isEmpty))
        case .Signup:
            return !((emailTextField.text!.isEmpty) || (passwordTextField.text!.isEmpty) || (usernameTextField.text!.isEmpty))
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField?.text, url: urlTextField?.text, completion: { (success, user) -> Void in
                    if success {
                        // dismiss view controller
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                       
                    }
                })
                
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success {
                        // dismiss view controller
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                       
                    }
                })
            }
        } else {
            switch mode {
            case .Signup:
                 self.presentValidationAlertWithTitle("Missing something?", text: "You'll need to enter a valid username, email and password before we can sign you up!")
            case .Login:
                self.presentValidationAlertWithTitle("We don't recognise that", text: "Please make sure you've entered the correct email and password")
            }
        }
    }
    
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewForMode(mode)
    }
    
    
    func updateViewForMode(mode: ViewMode) {
        switch mode {
        case .Signup:
            loginButton.setTitle("Sign up", forState: .Normal)
            usernameTextField.hidden = false
            emailTextField.hidden = false
            passwordTextField.hidden = false
            bioTextField.hidden = false
            urlTextField.hidden = false
            
        case .Login:
            loginButton.setTitle("Login", forState: .Normal)
            usernameTextField.hidden = true
            emailTextField.hidden = false
            passwordTextField.hidden = false
            bioTextField.hidden = true
            urlTextField.hidden = true
        }
    }

    
    func presentValidationAlertWithTitle(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
