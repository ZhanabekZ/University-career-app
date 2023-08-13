//
//  VacancyFilterViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 17.05.2023.
//
import UIKit

class VacancyFilterViewController: UIViewController {
    
    private let specializationSelectionButton = UIButton(type: .system)
    private let specializationDropdownButton = UIButton(type: .system)
    private var selectedSpecializations: [String] = []
    private var specializationButtons: [UIButton] = []
    private var specializationDropdownVisible = false
    private let specializationDropdownView = UIView()
    private var specializationDropdown0HeightConstraint: NSLayoutConstraint!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let keywordTextField = UITextField()
    let companyTextField = UITextField()
    let locationPicker = UIPickerView()
    let specializations = ["IT Management and Consulting", "IT Sales and Marketing", "Software Development", "Data Science and Analytics", "Cybersecurity", "UI/UX Design", "Software Testing"]
    let fullTimeSwitch = UISwitch()
    let partTimeSwitch = UISwitch()
    let remoteSwitch = UISwitch()
    let onsiteSwitch = UISwitch()
    let showVacanciesButton = UIButton()
    let locations = ["All cities", "Astana", "Almaty", "Aktau", "Aktobe", "Arkalyk", "Atyrau", "Baikonur", "Balqash", "Ekibastuz", "Karagandy", "Kentau", "Kyzylorda", "Kokshetau", "Kostanay", "Oral", "Oskemen", "Pavlodar", "Petropavl", "Qonaev", "Rudny", "Semey", "Stepnogorsk", "Shymkent", "Taldyqorgan", "Taraz", "Temirtau", "Turkistan", "Zhanaozen", "Zhezkazgan"]
    var selectedLocation = "All cities"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resetButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetFilters))
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeFilter))
        navigationItem.leftBarButtonItem = resetButton
        navigationItem.rightBarButtonItem = closeButton
        
        setupViews()
        setupConstraints()
        setupSpecializationDropdownView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        if let currentKeyword = UserDefaults.standard.string(forKey: "FilterKeyword") {
            keywordTextField.text = currentKeyword
        }
        if let currentCompany = UserDefaults.standard.string(forKey: "FilterCompany") {
            companyTextField.text = currentCompany
        }
        if let currentSpecializations = UserDefaults.standard.stringArray(forKey: "FilterSpecialization") {
            selectedSpecializations = currentSpecializations
            for button in specializationButtons {
                if selectedSpecializations.contains(button.titleLabel?.text ?? "") {
                    button.isSelected = true
                }
            }
        }
        
        fullTimeSwitch.isOn = UserDefaults.standard.bool(forKey: "FullTimeSwitchValue")
        partTimeSwitch.isOn = UserDefaults.standard.bool(forKey: "PartTimeSwitchValue")
        remoteSwitch.isOn = UserDefaults.standard.bool(forKey: "RemoteSwitchValue")
        onsiteSwitch.isOn = UserDefaults.standard.bool(forKey: "OnsiteSwitchValue")
        
        
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if specializationDropdownVisible {
            specializationDropdownVisible = false
            specializationDropdown0HeightConstraint.isActive = true
            
            specializationDropdownView.isHidden = true
            specializationDropdownView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        keywordTextField.translatesAutoresizingMaskIntoConstraints = false
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        fullTimeSwitch.translatesAutoresizingMaskIntoConstraints = false
        partTimeSwitch.translatesAutoresizingMaskIntoConstraints = false
        remoteSwitch.translatesAutoresizingMaskIntoConstraints = false
        onsiteSwitch.translatesAutoresizingMaskIntoConstraints = false
        showVacanciesButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure views
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]

        keywordTextField.placeholder = "Enter keywords"
        keywordTextField.inputAccessoryView = toolbar
        keywordTextField.borderStyle = .roundedRect
        companyTextField.placeholder = "Enter company name"
        companyTextField.inputAccessoryView = toolbar
        companyTextField.borderStyle = .roundedRect
        
        // Configure the appearance of the selection button
        specializationSelectionButton.setTitleColor(.black, for: .normal)
        specializationSelectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        specializationSelectionButton.setTitle("Select Specializations", for: .normal)
        specializationSelectionButton.addTarget(self, action: #selector(showSpecializationDropdown), for: .touchUpInside)
        specializationSelectionButton.layer.borderWidth = 1.0
        specializationSelectionButton.layer.borderColor = UIColor.black.cgColor
        specializationSelectionButton.layer.cornerRadius = 5.0
        specializationSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(specializationSelectionButton)
        
        // Configure the appearance of the dropdown button
        specializationDropdownButton.setTitle("▽", for: .normal)
        specializationDropdownButton.setTitleColor(.black, for: .normal)
        specializationDropdownButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        specializationDropdownButton.isUserInteractionEnabled = false
        specializationDropdownButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(specializationDropdownButton)
        
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        fullTimeSwitch.isOn = true
        fullTimeSwitch.onTintColor = .systemGreen
        
        partTimeSwitch.isOn = true
        partTimeSwitch.onTintColor = .systemGreen
        
        remoteSwitch.isOn = true
        remoteSwitch.onTintColor = .systemGreen
        
        onsiteSwitch.isOn = true
        onsiteSwitch.onTintColor = .systemGreen
        
        let filterSwitches = [fullTimeSwitch, partTimeSwitch, remoteSwitch, onsiteSwitch]
        let switchLabels = ["Full-time", "Part-time", "Remote", "Onsite"]

        assignLabelsToSwitches(switches: filterSwitches, labels: switchLabels)
        
        showVacanciesButton.setTitle("Show vacancies", for: .normal)
        showVacanciesButton.setTitleColor(.white, for: .normal)
        showVacanciesButton.backgroundColor = UIColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
        showVacanciesButton.layer.cornerRadius = 5
        showVacanciesButton.addTarget(self, action: #selector(showVacancies), for: .touchUpInside)
        
        // Add views to content view
        contentView.addSubview(keywordTextField)
        contentView.addSubview(companyTextField)
        contentView.addSubview(locationPicker)
        contentView.addSubview(fullTimeSwitch)
        contentView.addSubview(partTimeSwitch)
        contentView.addSubview(remoteSwitch)
        contentView.addSubview(onsiteSwitch)
        contentView.addSubview(showVacanciesButton)
        
        // Add views to view hierarchy
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupSpecializationDropdownView() {
        specializationDropdownView.translatesAutoresizingMaskIntoConstraints = false
        specializationDropdownView.backgroundColor = .white
        specializationDropdownView.layer.borderWidth = 1.0
        specializationDropdownView.layer.borderColor = UIColor.black.cgColor
        specializationDropdownView.layer.cornerRadius = 5.0
        contentView.addSubview(specializationDropdownView)
        print(specializationDropdownVisible)
        specializationDropdown0HeightConstraint = specializationDropdownView.heightAnchor.constraint(equalToConstant: 0)
        specializationDropdown0HeightConstraint.isActive = true

        var previousButton: UIButton?
        for specialization in specializations {
            let button = UIButton(type: .system)
            button.tintColor = UIColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
            button.setTitle(specialization, for: .normal)
            button.setTitleColor(.black, for: .application)
            
            button.addTarget(self, action: #selector(selectSpecialization(_:)), for: .touchUpInside)
            specializationButtons.append(button)
            specializationDropdownView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: specializationDropdownView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: specializationDropdownView.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 18)
                // Add additional constraints as needed
            ])
            if let previousButton = previousButton {
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 10).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: specializationDropdownView.topAnchor, constant: 7).isActive = true
            }
            previousButton = button
        }
        NSLayoutConstraint.activate([
            specializationDropdownView.leadingAnchor.constraint(equalTo: specializationSelectionButton.leadingAnchor),
            specializationDropdownView.trailingAnchor.constraint(equalTo: specializationSelectionButton.trailingAnchor),
            specializationDropdownView.topAnchor.constraint(equalTo: specializationSelectionButton.bottomAnchor, constant: 3),
            specializationDropdownView.bottomAnchor.constraint(equalTo: previousButton?.bottomAnchor ?? specializationSelectionButton.bottomAnchor, constant: 8)
        ])
        
        specializationDropdownView.isHidden = true // Hide the dropdown view initially
        specializationDropdownView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }

        
    @objc private func showSpecializationDropdown() {
        specializationDropdownVisible.toggle()
        specializationDropdown0HeightConstraint.isActive = !specializationDropdownVisible

        UIView.animate(withDuration: 0.3) {
            self.specializationDropdownView.transform = CGAffineTransform.identity
        }
        if specializationDropdownVisible {
            specializationDropdownView.isHidden = false
        } else {
            specializationDropdownView.isHidden = true
            specializationDropdownView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }

        
    @objc private func selectSpecialization(_ sender: UIButton) {
        sender.isSelected.toggle() // Toggle the selected state of the button
        
        if sender.isSelected {
            // Add the specialization to the selectedSpecializations array
            if let specialization = sender.title(for: .normal) {
                selectedSpecializations.append(specialization)
            }
        } else {
            // Remove the specialization from the selectedSpecializations array
            if let specialization = sender.title(for: .normal) {
                selectedSpecializations.removeAll { $0 == specialization }
            }
        }
    }
    
    func assignLabelsToSwitches(switches: [UISwitch], labels: [String]) {
        guard switches.count == labels.count else {
            print("Number of switches and labels must be the same.")
            return
        }
        
        for (index, switchControl) in switches.enumerated() {
            let label = labels[index]
            let labelView = UILabel()
            labelView.text = label
            labelView.translatesAutoresizingMaskIntoConstraints = false
            switchControl.addSubview(labelView)
            
            NSLayoutConstraint.activate([
                labelView.trailingAnchor.constraint(equalTo: switchControl.leadingAnchor, constant: -7),
                labelView.centerYAnchor.constraint(equalTo: switchControl.centerYAnchor)
            ])
        }
    }
    
    func setupConstraints() {
        let contentViewMargins = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            keywordTextField.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            keywordTextField.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            keywordTextField.topAnchor.constraint(equalTo: contentViewMargins.topAnchor),
            keywordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            companyTextField.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            companyTextField.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            companyTextField.topAnchor.constraint(equalTo: keywordTextField.bottomAnchor, constant: 16),
            companyTextField.heightAnchor.constraint(equalToConstant: 40),
            
            locationPicker.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor),
            locationPicker.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor),
            locationPicker.topAnchor.constraint(equalTo: companyTextField.bottomAnchor, constant: 16),
            locationPicker.heightAnchor.constraint(equalToConstant: 120),
            
            specializationSelectionButton.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor, constant: 50),
            specializationSelectionButton.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor, constant: -50),
            specializationSelectionButton.topAnchor.constraint(equalTo: locationPicker.bottomAnchor, constant: 50),
            
            specializationDropdownButton.trailingAnchor.constraint(equalTo: specializationSelectionButton.trailingAnchor, constant: -10),
            specializationDropdownButton.centerYAnchor.constraint(equalTo: specializationSelectionButton.centerYAnchor),
            specializationDropdownButton.widthAnchor.constraint(equalToConstant: 40),
            specializationDropdownButton.heightAnchor.constraint(equalToConstant: 40),
            
            fullTimeSwitch.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor, constant: 120),
            fullTimeSwitch.topAnchor.constraint(equalTo: specializationSelectionButton.bottomAnchor, constant: 30),

            partTimeSwitch.leadingAnchor.constraint(equalTo: fullTimeSwitch.trailingAnchor, constant: 135),
            partTimeSwitch.centerYAnchor.constraint(equalTo: fullTimeSwitch.centerYAnchor),

            remoteSwitch.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor, constant: 120),
            remoteSwitch.topAnchor.constraint(equalTo: fullTimeSwitch.bottomAnchor, constant: 30),

            onsiteSwitch.leadingAnchor.constraint(equalTo: remoteSwitch.trailingAnchor, constant: 135),
            onsiteSwitch.centerYAnchor.constraint(equalTo: remoteSwitch.centerYAnchor),
            
            showVacanciesButton.leadingAnchor.constraint(equalTo: contentViewMargins.leadingAnchor, constant: 40),
            showVacanciesButton.trailingAnchor.constraint(equalTo: contentViewMargins.trailingAnchor, constant: -40),
            showVacanciesButton.topAnchor.constraint(equalTo: onsiteSwitch.bottomAnchor, constant: 30),
            showVacanciesButton.heightAnchor.constraint(equalToConstant: 40),
            showVacanciesButton.bottomAnchor.constraint(equalTo: contentViewMargins.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: showVacanciesButton.bottomAnchor),
        ])
    }

    @objc func resetFilters() {
        keywordTextField.text = nil
        companyTextField.text = nil
        locationPicker.selectRow(0, inComponent: 0, animated: false)
        fullTimeSwitch.isOn = true
        partTimeSwitch.isOn = true
        remoteSwitch.isOn = true
        onsiteSwitch.isOn = true
        
        for button in specializationButtons {
            button.isSelected = false
        }
        selectedSpecializations.removeAll()
        specializationDropdownView.isHidden = true
        
    }

    @objc func closeFilter() {
        UserDefaults.standard.set(keywordTextField.text, forKey: "FilterKeyword")
        UserDefaults.standard.set(companyTextField.text, forKey: "FilterCompany")
        UserDefaults.standard.set(selectedSpecializations, forKey: "FilterSpecialization")
        UserDefaults.standard.set(fullTimeSwitch.isOn, forKey: "FullTimeSwitchValue")
        UserDefaults.standard.set(partTimeSwitch.isOn, forKey: "PartTimeSwitchValue")
        UserDefaults.standard.set(remoteSwitch.isOn, forKey: "RemoteSwitchValue")
        UserDefaults.standard.set(onsiteSwitch.isOn, forKey: "OnsiteSwitchValue")
        
        dismiss(animated: true, completion: nil)
        let vc = VacanciesViewController(vacancies: vacancies)
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func doneButtonTapped() {
        // Handle the "Done" button action here, such as dismissing the keyboard
        keywordTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
    }

    @objc func showVacancies() {
        // Apply the selected filters and display the filtered vacancies
        UserDefaults.standard.set(keywordTextField.text, forKey: "FilterKeyword")
        UserDefaults.standard.set(companyTextField.text, forKey: "FilterCompany")
        UserDefaults.standard.set(selectedSpecializations, forKey: "FilterSpecialization")
        UserDefaults.standard.set(fullTimeSwitch.isOn, forKey: "FullTimeSwitchValue")
        UserDefaults.standard.set(partTimeSwitch.isOn, forKey: "PartTimeSwitchValue")
        UserDefaults.standard.set(remoteSwitch.isOn, forKey: "RemoteSwitchValue")
        UserDefaults.standard.set(onsiteSwitch.isOn, forKey: "OnsiteSwitchValue")

        let filteredVacancies = vacancies.filter { vacancy in
            var matchesFilters = true
            
            // Check keyword filter
            if let keywords = keywordTextField.text, !keywords.isEmpty {
                let lowercaseKeywords = keywords.lowercased()
                if vacancy.title.lowercased().contains(lowercaseKeywords) || vacancy.description.lowercased().contains(lowercaseKeywords) {
                    matchesFilters = true
                } else {
                    matchesFilters = false // No match for keyword filter
                }
            }
            // Check company filter
            if let companyName = companyTextField.text, !companyName.isEmpty {
                let lowercaseCompanyName = companyName.lowercased()
                if vacancy.company.lowercased().contains(lowercaseCompanyName) {
                    matchesFilters = true
                } else {
                    matchesFilters = false // No match for keyword filter
                }
            }
            // Check location filter
            if selectedLocation != "All cities" && vacancy.location != selectedLocation {
                matchesFilters = false
            }

            
            // Check specialization filter
            if !selectedSpecializations.contains(vacancy.specialization) && !selectedSpecializations.isEmpty {
                matchesFilters = false
            }
            // Check employment type filters
            var isEmploymentTypeSelected = false
            if partTimeSwitch.isOn && vacancy.isPartTime {
                isEmploymentTypeSelected = true
            }
            if fullTimeSwitch.isOn && vacancy.isFullTime {
                isEmploymentTypeSelected = true
            }
            
            if remoteSwitch.isOn && vacancy.isRemote {
                isEmploymentTypeSelected = true
            }
            if onsiteSwitch.isOn && vacancy.isOnsite {
                isEmploymentTypeSelected = true
            }
            if !isEmploymentTypeSelected {
                matchesFilters = false
            }
            
            return matchesFilters
        }
        
        // Display the filtered vacancies
        let filteredVacanciesViewController = VacanciesViewController(vacancies: filteredVacancies)
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(filteredVacanciesViewController, animated: true)
    }
}

extension VacancyFilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLocation = locations[row]
    }
}

           

