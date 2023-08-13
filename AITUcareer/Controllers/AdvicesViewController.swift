//
//  AdvicesViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 03.05.2023.
//

import UIKit

class AdvicesViewController: UIViewController {
    
    
    
    var selectedCategory: String?
    var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Advices"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        
        // Drop-down button to select advice category
        let categoryButton = UIButton(type: .system)
        categoryButton.setTitle("Select Category", for: .normal)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryButton)
        
        // Advice label to display selected advice
        adviceLabel = UILabel()
        adviceLabel.textAlignment = .center
        adviceLabel.numberOfLines = 0
        adviceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adviceLabel)
        
        NSLayoutConstraint.activate([
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            adviceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adviceLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 20),
            adviceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            adviceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func categoryButtonTapped() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        
        for category in adviceCategories {
            let categoryAction = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.selectedCategory = category
                self?.updateAdviceLabel()
            }
            alertController.addAction(categoryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateAdviceLabel() {
        guard let selectedCategory = selectedCategory, let selectedAdvices = advices[selectedCategory] else {
            adviceLabel.text = "No advice selected"
            return
        }
        
        let adviceText = selectedAdvices.joined(separator: "\n")
        adviceLabel.text = "\(selectedCategory)\n\n\(adviceText)"
    }
    
    @objc func profileButtonTapped() {
        let detailVC = ProfileViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
