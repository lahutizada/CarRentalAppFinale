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
    
    let defaults = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    private func configureUI() {
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
        
        defaults.setData(value: true, key: .IsLoggedIn)

        goToMainAnimated()
    }
    private func goToMainAnimated() {

        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(
            withIdentifier: "TabBarController"
        )

        UIView.transition(
            with: window,
            duration: 0.35,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController = tabBarVC
            },
            completion: nil
        )
    }
}
