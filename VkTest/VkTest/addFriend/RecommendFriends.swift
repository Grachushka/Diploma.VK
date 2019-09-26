//
//  RecommendFriends.swift
//  VkTest
//
//  Created by Pavel Procenko on 26/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct RecommendFriends: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [RecommendFriend]
}

// MARK: - Item
struct RecommendFriend: Codable {
    let id: Int?
    let firstName, lastName: String?
    let sex: Int?
    let nickname, domain, screenName: String?
    let bdate: String?
    let city, country: City?
    let photo50, photo100, photo200, photoMax: String?
    let photo200_Orig: String?
    let photo400_Orig: String?
    let photoMaxOrig: String?
    let photoID: String?
    let hasPhoto, hasMobile, isFriend, friendStatus: Int?
    let online: Int?
    let onlineApp, onlineMobile: Int?
    let wallComments, canPost, canSeeAllPosts, canSeeAudio: Int?
    let canWritePrivateMessage, canSendFriendRequest: Int?
    let homePhone, skype, instagram: String?
    let site: String?
    let status: String?
    let lastSeen: LastSeen?
    let cropPhoto: CropPhoto?
    let verified: Int?
    let followersCount: Int?
    let blacklisted, blacklistedByMe, isFavorite, isHiddenFromFeed: Int?
    let commonCount: Int?
    let trackCode: String?
    let mobilePhone: String?
    let occupation: Occupation?
    let career: [Career]?
    let university: Int?
    let universityName: String?
    let faculty: Int?
    let facultyName: String?
    let graduation: Int?
    let educationForm, educationStatus, homeTown: String?
    let relation: Int?
    let personal: Personal?
    let interests, music, activities: String?
    let movies: String?
    let tv, books, games: String?
    let universities: [University]?
    let schools: [School]?
    let about: String?
    let relatives: [Occupation]?
    let quotes, maidenName, twitter: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex, nickname, domain
        case screenName = "screen_name"
        case bdate, city, country
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case photoMax = "photo_max"
        case photo200_Orig = "photo_200_orig"
        case photo400_Orig = "photo_400_orig"
        case photoMaxOrig = "photo_max_orig"
        case photoID = "photo_id"
        case hasPhoto = "has_photo"
        case hasMobile = "has_mobile"
        case isFriend = "is_friend"
        case friendStatus = "friend_status"
        case online
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
        case wallComments = "wall_comments"
        case canPost = "can_post"
        case canSeeAllPosts = "can_see_all_posts"
        case canSeeAudio = "can_see_audio"
        case canWritePrivateMessage = "can_write_private_message"
        case canSendFriendRequest = "can_send_friend_request"
        case homePhone = "home_phone"
        case skype, instagram, site, status
        case lastSeen = "last_seen"
        case cropPhoto = "crop_photo"
        case verified
        case followersCount = "followers_count"
        case blacklisted
        case blacklistedByMe = "blacklisted_by_me"
        case isFavorite = "is_favorite"
        case isHiddenFromFeed = "is_hidden_from_feed"
        case commonCount = "common_count"
        case trackCode = "track_code"
        case mobilePhone = "mobile_phone"
        case occupation, career, university
        case universityName = "university_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation
        case educationForm = "education_form"
        case educationStatus = "education_status"
        case homeTown = "home_town"
        case relation, personal, interests, music, activities, movies, tv, books, games, universities, schools, about, relatives, quotes
        case maidenName = "maiden_name"
        case twitter
    }
}

// MARK: - Career
struct Career: Codable {
    let groupID, countryID, cityID: Int?
    let company: String?
    let from, until: Int?

    enum CodingKeys: String, CodingKey {
        case groupID = "group_id"
        case countryID = "country_id"
        case cityID = "city_id"
        case company, from, until
    }
}

//// MARK: - City
//struct City: Codable {
//    let id: Int
//    let title: String
//}
//
//// MARK: - CropPhoto
//struct CropPhoto: Codable {
//    let photo: Photo
//    let crop, rect: Crop
//}
//
//// MARK: - Crop
//struct Crop: Codable {
//    let x, y, x2, y2: Double
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let id, albumID, ownerID: Int
//    let photo75, photo130, photo604: String
//    let photo807: String?
//    let width, height: Int
//    let text: String
//    let date, postID: Int
//    let photo1280, photo2560: String?
//    let lat, long: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case photo75 = "photo_75"
//        case photo130 = "photo_130"
//        case photo604 = "photo_604"
//        case photo807 = "photo_807"
//        case width, height, text, date
//        case postID = "post_id"
//        case photo1280 = "photo_1280"
//        case photo2560 = "photo_2560"
//        case lat, long
//    }
//}

// MARK: - LastSeen
//struct LastSeen: Codable {
//    let time, platform: Int
//}
//
//// MARK: - Occupation
//struct Occupation: Codable {
//    let type: TypeEnum
//    let name: String?
//    let id: Int?
//}
//
//enum TypeEnum: String, Codable {
//    case parent = "parent"
//    case sibling = "sibling"
//    case university = "university"
//    case work = "work"
//}

// MARK: - Personal
//struct Personal: Codable {
//    let political: Int?
//    let langs: [String]
//    let peopleMain, lifeMain, smoking, alcohol: Int?
//    let religion, inspiredBy: String?
//
//    enum CodingKeys: String, CodingKey {
//        case political, langs
//        case peopleMain = "people_main"
//        case lifeMain = "life_main"
//        case smoking, alcohol, religion
//        case inspiredBy = "inspired_by"
//    }
//}

// MARK: - School
//struct School: Codable {
//    let id: String
//    let country, city: Int
//    let name: String
//    let yearFrom, yearTo: Int?
//    let schoolClass: String
//    let type: Int?
//    let typeStr: String?
//    let yearGraduated: Int?
//    let speciality: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, country, city, name
//        case yearFrom = "year_from"
//        case yearTo = "year_to"
//        case schoolClass = "class"
//        case type
//        case typeStr = "type_str"
//        case yearGraduated = "year_graduated"
//        case speciality
//    }
//}

// MARK: - University
//struct University: Codable {
//    let id, country, city: Int
//    let name: String
//    let faculty: Int
//    let facultyName: String
//    let chair: Int
//    let chairName, educationForm: String
//    let educationStatus: String?
//    let graduation: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, country, city, name, faculty
//        case facultyName = "faculty_name"
//        case chair
//        case chairName = "chair_name"
//        case educationForm = "education_form"
//        case educationStatus = "education_status"
//        case graduation
//    }
//}
