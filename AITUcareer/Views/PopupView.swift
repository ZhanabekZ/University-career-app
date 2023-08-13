//
//  PopupView.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 11.07.2023.
//

import UIKit

class PopupView: UIView {

    var closeButtonAction: (() -> Void)?

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let coverLetterTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cover letter"
        return textField
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 25
        addSubview(titleLabel)
        addSubview(coverLetterTextField)
        addSubview(closeButton)
        addSubview(applyButton)
        addSubview(lineView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        coverLetterTextField.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Position constraints for the title label
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Position constraints for the cover letter text field
            coverLetterTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            coverLetterTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            coverLetterTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Position constraints for the close button
            closeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            // Position constraints for the apply button
            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            applyButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 16),
            applyButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    @objc func applyButtonTapped() {
        let ac = UIAlertController(title: "Application submitted.", message: "", preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        // Find the view controller to present the UIAlertController
        var responder: UIResponder? = self.next
        while responder != nil {
            if let viewController = responder as? UIViewController {
                viewController.present(ac, animated: true)
                break
            }
            responder = responder?.next
        }
        closeButtonAction?()
    }
    
    @objc func closeButtonTapped() {
        closeButtonAction?()
    }
    
}







