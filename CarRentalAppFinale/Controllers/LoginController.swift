//
//  LoginController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 28.12.25.
//

import UIKit
import UniformTypeIdentifiers

class LoginController: UIViewController, RegisterDelegate {
    

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let defaults = DataManager()
    var users = [RegisterData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataToFile()
    }
    
    private func configureUI() {
        emailTextField.layer.cornerRadius = 35
        emailTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 35
        passwordTextField.clipsToBounds = true
        loginButton.layer.cornerRadius = 35
        loginButton.clipsToBounds = true
        loginButton.tintColor = .loginBlack
        registrationButton.layer.cornerRadius = 35
        registrationButton.clipsToBounds = true
        registrationButton.tintColor = .loginBlack
        errorLabel.isHidden = true
        
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        print("NAV:", navigationController as Any)
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(RegistrationController.self)") as! RegistrationController
        
        controller.delegate = self
        
        present(controller, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        handleLogin()
    }

    // MARK: - Login Logic

    private func handleLogin() {

        errorLabel.isHidden = true

        guard let email = emailTextField.text, !email.isEmpty else {
            showError("Email boş ola bilməz")
            return
        }

        guard Validator.isValidEmail(email) else {
            showError("Email formatı düzgün deyil")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            showError("Şifrə boş ola bilməz")
            return
        }

        guard password.count >= 5 && password.count <= 10 else {
            showError("Şifrə 5–10 simvol olmalıdır")
            return
        }

        let inputEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        let isValidUser = users.contains {
            $0.email == inputEmail && $0.password == inputPassword
        }

        guard isValidUser else {
            showError("Email və ya şifrə yanlışdır")
            return
        }

        // ✅ УСПЕШНЫЙ ЛОГИН
        errorLabel.text = "Uğurlu giriş!"
        errorLabel.textColor = .systemGreen
        errorLabel.isHidden = false

        defaults.setData(value: true, key: .IsLoggedIn)
        defaults.setData(value: inputEmail, key: .currentUserEmail)

        switchToMain()
    }

    // MARK: - Navigation

    private func switchToMain() {

        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = scene.delegate as? SceneDelegate,
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
            }
        )
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = false

        errorLabel.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.errorLabel.alpha = 1
        }

        UINotificationFeedbackGenerator()
            .notificationOccurred(.error)
    }
    
    func didRegister(email: String, password: String) {
        emailTextField.text = email
        passwordTextField.text = password
        
        loadDataToFile()
    }
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("Users", conformingTo: .json)
        print(url)
        return url
    }
    private func loadDataToFile() {
        let url = getFilePath()

        guard FileManager.default.fileExists(atPath: url.path) else {
            users = []
            return
        }

        do {
            let data = try Data(contentsOf: url)
            users = try JSONDecoder().decode([RegisterData].self, from: data)
        } catch {
            print(error.localizedDescription)
            users = []
        }
    }
}
