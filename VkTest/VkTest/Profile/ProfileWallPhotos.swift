//
//  ProfileWallPhotos.swift
//  VkTest
//
//  Created by Pavel Procenko on 27/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct Parse123: Codable {
    let response: Response333
}

// MARK: - Response
struct Response333: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604, photo807: String?
    let photo1280, photo2560: String?
    let width, height: Int?
    let text: String?
    let date, postID: Int?
    let likes: Likes?
    let reposts: Reposts?
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case photo2560 = "photo_2560"
        case width, height, text, date
        case postID = "post_id"
        case likes, reposts, lat, long
    }
}

// MARK: - Likes
//struct Likes: Codable {
//    let userLikes, count: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case userLikes = "user_likes"
//        case count
//    }
//}

// MARK: - Reposts
//struct Reposts: Codable {
//    let count: Int?
//}
//struct Parse123: Codable {
//    let response: Response123
//}
//
//// MARK: - Response
//struct Response123: Codable {
//    let count: Int
//    let items: [Item]
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let id, albumID, ownerID: Int?
//    let photo75, photo130, photo604: String?
//    let text: String?
//    let date: Int?
//    let postID: Int?
//    let photo807, photo1280: String?
//    let width, height: Int?
//    let photo2560: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case photo75 = "photo_75"
//        case photo130 = "photo_130"
//        case photo604 = "photo_604"
//        case text, date
//        case postID = "post_id"
//        case photo807 = "photo_807"
//        case photo1280 = "photo_1280"
//        case width, height
//        case photo2560 = "photo_2560"
//    }
//}

