//
//  LoginController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 28.12.25.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    func configureUI() {
        emailTextField.layer.cornerRadius = 35
        emailTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 35
        passwordTextField.clipsToBounds = true
        loginButton.layer.cornerRadius = 35
        loginButton.clipsToBounds = true
        loginButton.tintColor = .loginBlack
        
    }
    
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
}
