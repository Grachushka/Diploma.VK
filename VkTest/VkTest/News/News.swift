//
//  News.swift
//  VkTest
//
//  Created by Pavel Procenko on 14.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object, Codable {
    
    @objc dynamic var response: ResponseNewsRealm?
    
}

struct News: Codable {
    let response: ResponseNews?
}

// MARK: - Response
class ResponseNewsRealm: Object, Codable {
    
    var items = List<OneNewsRealm>()
    var profiles = List<ProfileRealm>()
    var groups = List<GroupRealm>()
    @objc dynamic var nextFrom: String?
    
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}
struct ResponseNews: Codable {
    let items: [OneNews]
    let profiles: [Profile]?
    let groups: [Group]?
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Group
//struct Group: Codable {
//    let id: Int?
//    let name, screenName: String?
//    let isClosed: Int?
//    let type: GroupType?
//    let isAdmin, isMember, isAdvertiser: Int?
//    let photo50, photo100, photo200: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case screenName = "screen_name"
//        case isClosed = "is_closed"
//        case type
//        case isAdmin = "is_admin"
//        case isMember = "is_member"
//        case isAdvertiser = "is_advertiser"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//        case photo200 = "photo_200"
//    }
//}

enum GroupType: String, Codable {
    case group = "group"
    case page = "page"
}

// MARK: - Item
class OneNewsRealm: Object, Codable {
    
    dynamic var sourceID: RealmOptional<Int> = RealmOptional()
    dynamic var date: RealmOptional<Int> = RealmOptional()
    @objc dynamic var text: String?
    //    dynamic var markedAsAds: RealmOptional<Int> = RealmOptional()
    var attachments = List<CopyHistoryAttachmentRealm>()
    //    @objc dynamic var postID: Int
    //    @objc dynamic var signerID: Int
    
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        //           case markedAsAds = "marked_as_ads"
        case attachments
        //case postSource = "post_source"
        //           case postID = "post_id"
        //           case signerID = "signer_id"
    }
}

struct OneNews: Codable {
    let type: PostTypeEnum?
    let sourceID, date: Int?
    let postType: PostTypeEnum?
    let text: String?
    let markedAsAds: Int?
    let attachments: [CopyHistoryAttachment]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let postID: Int?
    let copyright: Copyright?
    let signerID: Int?
    
    enum CodingKeys: String, CodingKey {
        case type
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        //case postSource = "post_source"
        case comments, likes, reposts
        case postID = "post_id"
        case copyright
        case signerID = "signer_id"
    }
}

// MARK: - Attachment
//struct Attachment: Codable {
//    let type: AttachmentType?
//    let photo: Photo?
//    let audio: Audio?
//    let video: Video?
//}

// MARK: - Audio
//struct Audio: Codable {
//    let artist: String?
//    let id, ownerID: Int?
//    let title: String?
//    let duration: Int?
//    let url: String?
//    let date, albumID, lyricsID, genreID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case artist, id
//        case ownerID = "owner_id"
//        case title, duration, url, date
//        case albumID = "album_id"
//        case lyricsID = "lyrics_id"
//        case genreID = "genre_id"
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let id, albumID, ownerID, userID: Int?
//    let photo75, photo130, photo604, photo807: String?
//    let photo1280: String?
//    let width, height: Int?
//    let text: String?
//    let date, postID: Int?
//    let accessKey: String?
//    let photo2560: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case albumID = "album_id"
//        case ownerID = "owner_id"
//        case userID = "user_id"
//        case photo75 = "photo_75"
//        case photo130 = "photo_130"
//        case photo604 = "photo_604"
//        case photo807 = "photo_807"
//        case photo1280 = "photo_1280"
//        case width, height, text, date
//        case postID = "post_id"
//        case accessKey = "access_key"
//        case photo2560 = "photo_2560"
//    }
//}
//
//enum AttachmentType: String, Codable {
//    case audio = "audio"
//    case photo = "photo"
//    case video = "video"
//}

// MARK: - Video
//struct Video: Codable {
//    let id, ownerID: Int?
//    let title: String?
//    let duration: Int?
//    let videoDescription: String?
//    let date, comments, views, width: Int?
//    let height: Int?
//    let photo130, photo320, photo800, photo1280: String?
//    let firstFrame320, firstFrame160, firstFrame4096, firstFrame130: String?
//    let firstFrame720, firstFrame1024, firstFrame1280, firstFrame800: String?
//    let accessKey: String?
//    let canAdd: Int?
//    let trackCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerID = "owner_id"
//        case title, duration
//        case videoDescription = "description"
//        case date, comments, views, width, height
//        case photo130 = "photo_130"
//        case photo320 = "photo_320"
//        case photo800 = "photo_800"
//        case photo1280 = "photo_1280"
//        case firstFrame320 = "first_frame_320"
//        case firstFrame160 = "first_frame_160"
//        case firstFrame4096 = "first_frame_4096"
//        case firstFrame130 = "first_frame_130"
//        case firstFrame720 = "first_frame_720"
//        case firstFrame1024 = "first_frame_1024"
//        case firstFrame1280 = "first_frame_1280"
//        case firstFrame800 = "first_frame_800"
//        case accessKey = "access_key"
//        case canAdd = "can_add"
//        case trackCode = "track_code"
//    }
//}

// MARK: - Comments
//struct Comments: Codable {
//    let count, canPost: Int?
//    let groupsCanPost: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case canPost = "can_post"
//        case groupsCanPost = "groups_can_post"
//    }
//}

// MARK: - Copyright
struct Copyright: Codable {
    let id: Int?
    let link: String?
    let type, name: String?
}

// MARK: - Likes
//struct Likes: Codable {
//    let count, userLikes, canLike, canPublish: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userLikes = "user_likes"
//        case canLike = "can_like"
//        case canPublish = "can_publish"
//    }
//}

// MARK: - PostSource
struct PostSource: Codable {
    let type: PostSourceType?
    let platform: Platform?
}

enum Platform: String, Codable {
    case android = "android"
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}


enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Reposts
//struct Reposts: Codable {
//    let count, userReposted: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case userReposted = "user_reposted"
//    }
//}

// MARK: - Profile
//struct Profile: Codable {
//    let id: Int?
//    let firstName, lastName: String?
//    let sex: Int?
//    let screenName: String?
//    let photo50, photo100: String?
//    let online: Int?
//    let onlineInfo: OnlineInfo?
//    let onlineApp, onlineMobile: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case sex
//        case screenName = "screen_name"
//        case photo50 = "photo_50"
//        case photo100 = "photo_100"
//        case online
//        case onlineInfo = "online_info"
//        case onlineApp = "online_app"
//        case onlineMobile = "online_mobile"
//    }
//}

// MARK: - OnlineInfo
//struct OnlineInfo: Codable {
//    let visible, isOnline: Bool?
//    let lastSeen, appID: Int?
//    let isMobile: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case visible
//        case isOnline = "is_online"
//        case lastSeen = "last_seen"
//        case appID = "app_id"
//        case isMobile = "is_mobile"
//    }
//}
