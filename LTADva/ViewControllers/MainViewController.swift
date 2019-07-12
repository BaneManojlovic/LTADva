//
//  ViewController.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        
        signupButton.layer.cornerRadius = 15
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Login btn tapped...")
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Signup btn tapped...")
        let registerVC = StoryboardScene.Auth.registerViewController.instantiate()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

