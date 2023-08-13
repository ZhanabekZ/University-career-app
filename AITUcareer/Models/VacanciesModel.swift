//
//  VacanciesModel.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 05.08.2023.
//

import Foundation

struct Vacancy {
    let title: String
    let description: String
    let company: String
    let location: String
    let isFullTime: Bool
    let isRemote: Bool
    let isPartTime: Bool
    let isOnsite: Bool
    let specialization: String
}

var vacancies: [Vacancy] = [
    Vacancy(title: "Software Engineer Intern", description: "We are actively looking for a Software Engineer Intern. As a software engineer intern, you will get hands-on experience working on one of the world's largest platforms to improve user experience. You will also get the opportunity to work alongside top developers, gaining essential knowledge on how to design a scalable and high-performance software platform. This is a very gratifying position since your efforts will directly influence the lives of millions of people in the region. Interns who do very well will be asked to apply for full-time positions following the completion of their internship.", company: "ABC Company", location: "Aktobe", isFullTime: false, isRemote: true, isPartTime: true, isOnsite: true, specialization: "Software Development"),
    Vacancy(title: "Marketing Intern", description: "dc", company: "XYZ Corporation", location: "Atyrau", isFullTime: false, isRemote: false, isPartTime: true, isOnsite: true, specialization: "IT Sales and Marketing"),
    Vacancy(title: "iOS Developer Intern", description: "dc", company: "123 Tech", location: "Atyrau", isFullTime: false, isRemote: false, isPartTime: true, isOnsite: false, specialization: "Software Development"),
    Vacancy(title: "Product Designer Intern", description: "dc", company: "Creative Designs", location: "Atyrau", isFullTime: false, isRemote: true, isPartTime: true, isOnsite: false, specialization: "UI/UX Design")
    ]
