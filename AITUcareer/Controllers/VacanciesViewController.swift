//
//  VacanciesViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 03.05.2023.
//
import UIKit

class VacanciesViewController: UIViewController {
    var vacancies: [Vacancy]
        
    init(vacancies: [Vacancy]) {
        self.vacancies = vacancies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vacancies"
        
        // Filter button in the left side of the navigation bar
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        

        
        // Checkboxes for filter criteria
        
        // Table view setup
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func filterButtonTapped() {
        let detailVC = VacancyFilterViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func profileButtonTapped() {
        let detailVC = ProfileViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension VacanciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let vacancy = vacancies[indexPath.row]
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        cell.detailTextLabel?.isEnabled = true
        cell.textLabel?.text = vacancy.title
        cell.textLabel?.textColor = .darkText
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.detailTextLabel?.text = "\(vacancy.company), \(vacancy.location)"
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.gray
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vacancy = vacancies[indexPath.row]
        let detailVC = VacancyDetailViewController(vacancy: vacancy)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

    
