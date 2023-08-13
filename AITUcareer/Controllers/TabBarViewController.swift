//
//  TabBarViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 02.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomePageController())
        let vc2 = UINavigationController(rootViewController: AdvicesViewController())
        let vc4 = UINavigationController(rootViewController: VacanciesViewController(vacancies: vacancies))
        let vc5 = UINavigationController(rootViewController: NewsViewController())
               
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "exclamationmark.bubble")
        vc4.tabBarItem.image = UIImage(systemName: "menucard")
        vc5.tabBarItem.image = UIImage(systemName: "newspaper")
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
                
        vc1.title = "Home"
        vc2.title = "Advices"
        vc4.title = "Vacancies"
        vc5.title = "News"
               
        setViewControllers([vc1, vc2, vc4, vc5], animated: true)
        

    }
    
}
