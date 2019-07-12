//
//  RegisterViewController.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        submitButton.layer.cornerRadius = 15
        submitButton.layer.borderWidth = 2
        submitButton.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        print("Submit button tapped...")
    }
    
}
