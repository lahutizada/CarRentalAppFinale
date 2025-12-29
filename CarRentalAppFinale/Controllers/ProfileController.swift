//
//  ProfileController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import UIKit
import UniformTypeIdentifiers

class ProfileController: UIViewController {
    
    let defaults = DataManager()
    var users = [RegisterData]()
    var padding = PaddingLabel()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        nameLabel.layer.cornerRadius = 20
        nameLabel.clipsToBounds = true
        surnameLabel.layer.cornerRadius = 20
        surnameLabel.clipsToBounds = true
        emailLabel.layer.cornerRadius = 20
        emailLabel.clipsToBounds = true
        birthLabel.layer.cornerRadius = 20
        birthLabel.clipsToBounds = true
        phoneLabel.layer.cornerRadius = 20
        phoneLabel.clipsToBounds = true
        logOutButton.tintColor = .loginBlack
        logOutButton.layer.cornerRadius = 30
        logOutButton.clipsToBounds = true
        
        loadDataToFile()
        loadUserData()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        goToLogin()
    }
}

//MARK: ProfileController Extension - (loadUserData), (goToLogin), (getFilePath), (loadDataToFile)
extension ProfileController {
    
    private func loadUserData() {
        guard
            let currentEmail = defaults.getData(key: .currentUserEmail) as? String,
            let user = users.first(where: { $0.email == currentEmail })
        else {
            clearLabels()
            return
        }
        
        nameLabel.text = "    Name: \(user.name ?? "")"
        surnameLabel.text = "    Surname: \(user.surname ?? "")"
        emailLabel.text = "    Email: \(user.email ?? "")"
        phoneLabel.text = "    Phone: \(user.phone ?? "")"
        birthLabel.text = "    Birth date: \(user.birth ?? "")"
    }
    
    private func clearLabels() {
        nameLabel.text = "    Name:"
        surnameLabel.text = "    Surname:"
        emailLabel.text = "    Email:"
        phoneLabel.text = "    Phone:"
        birthLabel.text = "    Birth date:"
    }
    
    func goToLogin() {

        defaults.setData(value: false, key: .IsLoggedIn)
        defaults.setData(value: "", key: .currentUserEmail)

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window
        else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginController"
        )

        UIView.transition(
            with: window,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController = loginVC
            }
        )
    }
    
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("Users", conformingTo: .json)
        print(url)
        return url
    }
    
    private func loadDataToFile() {
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([RegisterData].self, from: data)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
