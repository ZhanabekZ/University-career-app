//
//  VacancyDetailViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 04.06.2023.
//

import UIKit

class VacancyDetailViewController: UIViewController {
    var vacancy: Vacancy
    
    init(vacancy: Vacancy) {
        self.vacancy = vacancy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let popupView = PopupView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    var dimmingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionTapped))
        setupViews()
        
    }
    @objc func actionTapped() {
        let textToShare = "Check out new vacancy on AITU Career: \(vacancy.title) \n Company: \(vacancy.company) \n Location: \(vacancy.location) \n Specialization: \(vacancy.specialization) \n\n \(vacancy.description)"
        let vc = UIActivityViewController(activityItems: [textToShare], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    private func setupViews() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = vacancy.title
        view.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = vacancy.description
        view.addSubview(descriptionLabel)
        
        let companyLabel = UILabel()
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.font = UIFont.systemFont(ofSize: 16)
        companyLabel.text = "Company: \(vacancy.company)"
        view.addSubview(companyLabel)
        
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.text = "Location: \(vacancy.location)"
        view.addSubview(locationLabel)
        
        let fullTimeLabel = UILabel()
        fullTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        fullTimeLabel.font = UIFont.systemFont(ofSize: 16)
        fullTimeLabel.text = "Full-time: \(vacancy.isFullTime ? "Yes" : "No")"
        view.addSubview(fullTimeLabel)
        
        let remoteLabel = UILabel()
        remoteLabel.translatesAutoresizingMaskIntoConstraints = false
        remoteLabel.font = UIFont.systemFont(ofSize: 16)
        remoteLabel.text = "Remote: \(vacancy.isRemote ? "Yes" : "No")"
        view.addSubview(remoteLabel)
        
        let partTimeLabel = UILabel()
        partTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        partTimeLabel.font = UIFont.systemFont(ofSize: 16)
        partTimeLabel.text = "Part-time: \(vacancy.isPartTime ? "Yes" : "No")"
        view.addSubview(partTimeLabel)
        
        let onsiteLabel = UILabel()
        onsiteLabel.translatesAutoresizingMaskIntoConstraints = false
        onsiteLabel.font = UIFont.systemFont(ofSize: 16)
        onsiteLabel.text = "On-site: \(vacancy.isOnsite ? "Yes" : "No")"
        view.addSubview(onsiteLabel)
        
        let specializationLabel = UILabel()
        specializationLabel.translatesAutoresizingMaskIntoConstraints = false
        specializationLabel.font = UIFont.systemFont(ofSize: 16)
        specializationLabel.text = "Specialization: \(vacancy.specialization)"
        view.addSubview(specializationLabel)
        
        let applyButton = UIButton(configuration: .filled())
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            companyLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            companyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fullTimeLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            fullTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            remoteLabel.topAnchor.constraint(equalTo: fullTimeLabel.bottomAnchor, constant: 10),
            remoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            remoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            partTimeLabel.topAnchor.constraint(equalTo: remoteLabel.bottomAnchor, constant: 10),
            partTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            partTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            onsiteLabel.topAnchor.constraint(equalTo: partTimeLabel.bottomAnchor, constant: 10),
            onsiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onsiteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            specializationLabel.topAnchor.constraint(equalTo: onsiteLabel.bottomAnchor, constant: 10),
            specializationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            specializationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            applyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            applyButton.topAnchor.constraint(equalTo: specializationLabel.bottomAnchor, constant: 100),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func applyButtonTapped() {
        dimmingView = UIView(frame: view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(dimmingView)
        
        popupView.titleLabel.text = "Apply for the vacancy"
        popupView.center = view.center
        popupView.closeButtonAction = { [weak self] in
            self?.dismissCustomPopup()
            self?.popupView.coverLetterTextField.text = ""
        }
        view.addSubview(popupView)
        
        popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3) {
            self.popupView.transform = .identity
        }
    }
    
    func dismissCustomPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.popupView.removeFromSuperview()
            self.dimmingView.removeFromSuperview()
        }
    }
    
}
