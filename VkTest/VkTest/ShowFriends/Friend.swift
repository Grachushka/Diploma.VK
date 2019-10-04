//
//  Friend.swift
//  VkTest
//
//  Created by Pavel Procenko on 14/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct Friends: Codable {
    let response: Response1
}

// MARK: - Response
struct Response1: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {    
    
    let id: Int
    let firstName, lastName: String?
    let sex: Int
    let nickname: String?
    let domain: String
    let bdate: String?
    let city, country: City?
    let photo50, photo100, photo200_Orig: String?
    let hasMobile: Int?
    let online, canPost: Int
    let canSeeAllPosts: Int?
    let canWritePrivateMessage: Int
    let mobilePhone, homePhone, status: String?
    let lastSeen: LastSeen?
    let university: Int?
    let universityName: String?
    let faculty: Int?
    let facultyName: String?
    let graduation, relation: Int?
    let universities: [University]?
    let trackCode: String
    let educationForm: EducationForm?
    let educationStatus: String?
    let relationPartner: RelationPartner?
    let lists: [Int]?
    let onlineApp, onlineMobile: Int?
    let deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex, nickname, domain, bdate, city, country
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200_Orig = "photo_200_orig"
        case hasMobile = "has_mobile"
        case online
        case canPost = "can_post"
        case canSeeAllPosts = "can_see_all_posts"
        case canWritePrivateMessage = "can_write_private_message"
        case mobilePhone = "mobile_phone"
        case homePhone = "home_phone"
        case status
        case lastSeen = "last_seen"
        case university
        case universityName = "university_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation, relation, universities
        case trackCode = "track_code"
        case educationForm = "education_form"
        case educationStatus = "education_status"
        case relationPartner = "relation_partner"
        case lists
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
        case deactivated
    }
}

// MARK: - City
//struct City: Codable {
//    let id: Int
//    let title: String
//}

enum EducationForm: String, Codable {
    case заочноеОтделение = "Заочное отделение"
    case очноЗаочноеОтделение = "Очно-заочное отделение"
    case очноеОтделение = "Очное отделение"
}

// MARK: - LastSeen
//struct LastSeen: Codable {
//    let time, platform: Int
//}

// MARK: - RelationPartner
struct RelationPartner: Codable {
    let id: Int
    let firstName, lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

// MARK: - University
struct University: Codable {
    let id, country, city: Int?
    let name: String?
    let faculty: Int?
    let facultyName: String?
    let chair: Int?
    let chairName: String?
    let graduation: Int?
    let educationForm: EducationForm?
    let educationStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case id, country, city, name, faculty
        case facultyName = "faculty_name"
        case chair
        case chairName = "chair_name"
        case graduation
        case educationForm = "education_form"
        case educationStatus = "education_status"
    }
}
