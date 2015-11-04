//
//  LoginSignupPickerViewController.swift
//  Timeline
//
//  Created by Mike Gilroy on 03/11/2015.
//  Copyright © 2015 Mike Gilroy. All rights reserved.
//

import UIKit

class LoginSignupPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        if segue.identifier == "showLoginView" {
            
            let loginScene = segue.destinationViewController as? LoginSignupViewController
            loginScene?.mode = LoginSignupViewController.ViewMode.Login
        }
        
        if segue.identifier == "showSignupView" {
            let loginScene = segue.destinationViewController as? LoginSignupViewController
            loginScene?.mode = LoginSignupViewController.ViewMode.Signup
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
