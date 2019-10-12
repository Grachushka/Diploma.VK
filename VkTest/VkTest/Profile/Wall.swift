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
    let attachments: [CopyHistoryAttachment]?

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

struct ItemAttachment: Codable {
    let type: AttachmentType?
    let link: Link?
    let photo: AttachmentPhoto?
    let video: PurpleVideo?
    let audio: Audio?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String?
    let id, ownerID: Int?
    let title: String?
    let duration: Int?
    let url: String?
    let date, lyricsID, genreID, albumID: Int?
    let contentRestricted: Int?

    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration, url, date
        case lyricsID = "lyrics_id"
        case genreID = "genre_id"
        case albumID = "album_id"
        case contentRestricted = "content_restricted"
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let title, caption, linkDescription: String?
    let isExternal: Int?
    let photo: LinkPhoto?

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case isExternal = "is_external"
        case photo
    }
}

// MARK: - LinkPhoto
struct LinkPhoto: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604: String?
    let width, height: Int?
    let text: String?
    let date: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case width, height, text, date
    }
}

// MARK: - AttachmentPhoto
struct AttachmentPhoto: Codable {
    let id, albumID, ownerID: Int?
    let photo75, photo130, photo604, photo807: String?
    let photo1280, photo2560: String?
    let width, height: Int?
    let text: String?
    let date: Int?
    let accessKey: String?
    let postID, userID: Int?

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
        case accessKey = "access_key"
        case postID = "post_id"
        case userID = "user_id"
    }
}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
    case graffiti = "graffiti"
    case note = "note"
    case app = "app"
    case poll = "poll"
    case page = "page"
    case album = "album"
    case photos_list = "photos_list"
    case market = "market"
    case market_album = "market_album"
    case sticker = "sticker"
    case pretty_cards = "pretty_cards"
    case event = "event"
    case posted_photo = "posted_photo"
    
    
}

// MARK: - PurpleVideo
struct PurpleVideo: Codable {
    let id, ownerID: Int?
    let title: String?
    let duration: Int?
    let videoDescription: String?
    let date, comments, views, width: Int?
    let height: Int?
    let photo130, photo320, photo800, photo1280: String?
    let firstFrame320, firstFrame160, firstFrame4096, firstFrame130: String?
    let firstFrame720, firstFrame1024, firstFrame1280, firstFrame800: String?
    let accessKey: String?
    let canAdd: Int?
    let trackCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, duration
        case videoDescription = "description"
        case date, comments, views, width, height
        case photo130 = "photo_130"
        case photo320 = "photo_320"
        case photo800 = "photo_800"
        case photo1280 = "photo_1280"
        case firstFrame320 = "first_frame_320"
        case firstFrame160 = "first_frame_160"
        case firstFrame4096 = "first_frame_4096"
        case firstFrame130 = "first_frame_130"
        case firstFrame720 = "first_frame_720"
        case firstFrame1024 = "first_frame_1024"
        case firstFrame1280 = "first_frame_1280"
        case firstFrame800 = "first_frame_800"
        case accessKey = "access_key"
        case canAdd = "can_add"
        case trackCode = "track_code"
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
    let type: AttachmentType?
    let audio: Audio?
    let link: Link?
    let photo: AttachmentPhoto?
    let video: PurpleVideo?
    let doc: Doc?
    
}

struct Doc: Codable {
    let id, ownerID: Int?
    let title: String?
    let size: Int?
    let ext: String?
    let url: String?
    let date, type: Int?
    let preview: Preview?
    let accessKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, size, ext, url, date, type, preview
        case accessKey = "access_key"
    }
}
struct Preview: Codable {
    let photo: PreviewPhoto?
    let video: VideoElement?
}

struct PreviewPhoto: Codable {
    let sizes: [VideoElement]?
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let src: String?
    let width, height: Int?
    let type: String?
    let fileSize: Int?

    enum CodingKeys: String, CodingKey {
        case src, width, height, type
        case fileSize = "file_size"
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
