//
//  NewsModel.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 06.08.2023.
//

import Foundation
import UIKit

struct NewsItem: Hashable {
    let NewsTitle: String
    let NewsDescription: String
    let NewsImage: UIImage
}

let newsItemsArray = [
    NewsItem(NewsTitle: "Ulken IT Meetup", NewsDescription: "June 9 - The TechOzimiz IT community organizes the Ulken Meetup, where experts from 1Fit, DAR, Kazpost and nFactorial Incubator will speak. Speech topics: building a career in IT, how to scale startups, infobusiness in IT. Also, there will be a quiz and networking. Participation by ticket, registration here: https://techozimiz.kz/.\nTicket price - 5000 tg.", NewsImage: UIImage(named: "Screenshot 2023-06-05 at 12.15.36.png") ?? UIImage()),
    NewsItem(NewsTitle: "FabLab AITU Open Day", NewsDescription: "On May 3, 2023, the FabLab Open House will take place in C1.1.341.\n\n🧪 FabLab is the research laboratory at AITU. At the event, you can learn about the different membership options and programs available to join the @aitu_fablab community.\n\n✅ Registration is available at \nhttps://clck.ru/34Jada", NewsImage: UIImage(named: "FabLabAITU.jpg") ?? UIImage()),
    NewsItem(NewsTitle: "Job Fair 2023", NewsDescription: "On April 28, Astana IT University hosted the Job Fair 2023. The main goal of this event is the familiarity between the students and representatives of companies, selecting the right organizations for internships, as well as for future employment. The students were able to learn more about career opportunities development and apply for positions of interest to them. \n\nThe job fair was attended by more than 47 international and domestic companies, among them were such companies as KPMG, Deloitte, PwC, Air Astana, Halyk Bank, Tengizchevroil, Kolesa Group and others. You can watch a video of the event via link:  https://youtu.be/ni_u_FC4prI", NewsImage: UIImage(named: "JobFairAITU.png") ?? UIImage())
]
