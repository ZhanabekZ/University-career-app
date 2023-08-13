//
//  ProfileViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 19.05.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let preferencesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(preferencesLabel)
        view.addSubview(logoutButton)
        
        // Set email label text
        if let currentUserEmail = Auth.auth().currentUser?.email {
            preferencesLabel.text = "Email: \(currentUserEmail)"
        }
        
        if let name = Auth.auth().currentUser?.displayName {
            titleLabel.text = name
        }
        
        
        // Set preferences label text
        
        // Setup constraints
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            preferencesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            preferencesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            logoutButton.widthAnchor.constraint(equalToConstant: 120),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            defaults.setValue(false, forKey: "isUserSignedIn")
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "launchPage")
                let nc = UINavigationController(rootViewController: vc)
                window.rootViewController = nc
                window.makeKeyAndVisible()
            }
        }
        catch {
            print("Error logging out")
        }
    }
}
