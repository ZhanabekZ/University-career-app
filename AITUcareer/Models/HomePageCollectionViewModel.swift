//
//  HomePageCollectionViewModel.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 07.05.2023.
//
import UIKit

struct HomePageDataModel: Hashable, Equatable {
    let category: String
    let itemTitle: String
    let itemImage: UIImage
    let itemDescription: String
}

let AdvicesItems = [
    HomePageDataModel(category: "Advices", itemTitle: "Career Development Tips", itemImage: UIImage(named: "kelly-sikkema--1_RZL8BGBM-unsplash.jpg") ?? UIImage(), itemDescription: "Build a Professional Network: Attend career fairs, industry events, and join professional organizations. Networking can lead to job opportunities and valuable connections for future career growth."),
    HomePageDataModel(category: "Advices", itemTitle: "About CV", itemImage: UIImage(named: "lycs-architecture-U2BI3GMnSSE-unsplash.jpg") ?? UIImage(), itemDescription: "Quantify Achievements: Whenever possible, include quantitative data to showcase your accomplishments. For example, mention the number of projects completed, clients served, or the impact of your work."),
    HomePageDataModel(category: "Advices", itemTitle: "Interviews", itemImage: UIImage(named: "maranda-vandergriff-7aakZdIl4vg-unsplash.jpg") ?? UIImage(), itemDescription: "Practice Common Interview Questions: Prepare responses to common interview questions, such as 'Tell me about yourself' or 'Why are you interested in this position?' Practicing will help you articulate your thoughts clearly and confidently."),
    HomePageDataModel(category: "Advices", itemTitle: "Job Search", itemImage: UIImage(named: "markus-winkler-7iSEHWsxPLw-unsplash.jpg") ?? UIImage(), itemDescription: "Utilize Career Services: Take advantage of your university's career services office. They can assist with resume reviews, interview preparation, job search strategies, and connecting you with alumni and employers.")
]

let VacanciesItems = [
    HomePageDataModel(category: "Vacancies", itemTitle: "Software Engineer Intern", itemImage: UIImage(named: "david-iskander-iWTamkU5kiI-unsplash.jpg") ?? UIImage(), itemDescription: "Please, check out Vacancies section."),
    HomePageDataModel(category: "Vacancies", itemTitle: "Marketing Intern", itemImage: UIImage(named: "glenn-carstens-peters-npxXWgQ33ZQ-unsplash.jpg") ?? UIImage(), itemDescription: "Please, check out Vacancies section.")
]

let NewsItems = [
    HomePageDataModel(category: "News", itemTitle: "Ulken IT Meetup", itemImage: UIImage(named: "Screenshot 2023-06-05 at 12.15.36.png") ?? UIImage(), itemDescription: "June 9 - The TechOzimiz IT community organizes the Ulken Meetup, where experts from 1Fit, DAR, Kazpost and nFactorial Incubator will speak.\nSpeech topics: building a career in IT, how to scale startups, infobusiness in IT. Also, there will be a quiz and networking.\nParticipation by ticket, registration here: https://techozimiz.kz/.\nTicket price - 5000 tg."),
    HomePageDataModel(category: "News", itemTitle: "FabLab AITU Open Day", itemImage: UIImage(named: "FabLabAITU.jpg") ?? UIImage(), itemDescription: "On May 3, 2023, the FabLab Open House will take place in C1.1.341.\n\n🧪 FabLab is the research laboratory at AITU. At the event, you can learn about the different membership options and programs available to join the AITU FabLab community.\n\n✅ Registration is available at \nhttps://clck.ru/34Jada"),
    HomePageDataModel(category: "News", itemTitle: "Job Fair 2023", itemImage: UIImage(named: "JobFairAITU.png") ?? UIImage(), itemDescription: "On April 28, Astana IT University hosted the Job Fair 2023. The main goal of this event is the familiarity between the students and representatives of companies, selecting the right organizations for internships, as well as for future employment. The students were able to learn more about career opportunities development and apply for positions of interest to them. \n\nThe job fair was attended by more than 47 international and domestic companies, among them were such companies as KPMG, Deloitte, PwC, Air Astana, Halyk Bank, Tengizchevroil, Kolesa Group and others. You can watch a video of the event via link:  https://youtu.be/ni_u_FC4prI")
]

let CompaniesItems = [
    HomePageDataModel(category: "Companies", itemTitle: "Beeline", itemImage: UIImage(named: "BeeLine_logo.png") ?? UIImage(), itemDescription: "The company offers mobile and fixed telephony, international and long-distance communications, data transmission, Internet access based on wireless technologies, fiber optic access, Wi-Fi, as well as third and fourth generation networks. In addition to the standard list of services Beeline provides a large number of digital-options: mobile finance, multimedia services, convergent services, Internet of things NB-IOT, and M2M, MDM, E2E solutions.\nBeeline Kazakhstan is recognized as the most respected operator in the country by the Reputation Institute reputation audit."),
    HomePageDataModel(category: "Companies", itemTitle: "EPAM", itemImage: UIImage(named: "epamLogo.png") ?? UIImage(), itemDescription: "EPAM is a large team of 31,000+ consultants, architects, designers, developers and engineers around the world. Using our experience and expertise, we create innovative technologies and help our clients solve global business challenges in more than 30 countries around the world. The pursuit of excellence is in our blood. Since 1993, we've been helping customers around the world conceive, develop, design and deploy software that changes the world. Today we're more than experts. We're experts who come up with innovative solutions to achieve real results.")

]


let categories = ["Advices", "Vacancies", "News", "Companies"]
