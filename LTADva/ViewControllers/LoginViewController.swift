//
//  LoginViewController.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Login button tapped...")
    }
    
}
