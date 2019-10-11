//
//  Wall.swift
//  VkTest
//
//  Created by Pavel Procenko on 07/10/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct Wall: Codable {
    let response: Response4442
}

// MARK: - Response
struct Response4442: Codable {
    let count: Int
    let items: [Item333]
    let profiles: [Profile]?
    let groups: [Group]?
}

// MARK: - Group
struct Group: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let isAdmin, isMember, isAdvertiser: Int?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct Item333: Codable {
    let id, fromID, ownerID, date: Int?
    let postType, text: String?
    let copyHistory: [CopyHistory]?
    let postSource: ItemPostSource?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let attachments: [ItemAttachment]?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case postType = "post_type"
        case text
        case copyHistory = "copy_history"
        case postSource = "post_source"
        case comments, likes, reposts, attachments
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: String?
    let photo: Photo1?
}

// MARK: - Photo
struct Photo1: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604, photo807: String?
    let photo1280, photo2560: String?
    let width, height: Int?
    let text: String?
    let date, postID, userID: Int?
    let accessKey: String?

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
        case userID = "user_id"
        case accessKey = "access_key"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let id, ownerID, fromID, date: Int?
    let postType, text: String?
    let attachments: [CopyHistoryAttachment]?
    let postSource: CopyHistoryPostSource?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case fromID = "from_id"
        case date
        case postType = "post_type"
        case text, attachments
        case postSource = "post_source"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: String?
    let photo: Photo?
    let audio: Audio?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String?
    let id, ownerID: Int?
    let title: String?
    let duration: Int?
    let url: String?
    let date, albumID: Int?

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration, url, date
        case albumID = "album_id"
    }
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    let type: String?
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    let type, platform, data: String?
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let id: Int?
    let firstName, lastName: String?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let online: Int?
    let onlineInfo: OnlineInfo?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case onlineInfo = "online_info"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible: Bool?
    let lastSeen, appID: Int?
    let isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case appID = "app_id"
        case isMobile = "is_mobile"
    }
}
