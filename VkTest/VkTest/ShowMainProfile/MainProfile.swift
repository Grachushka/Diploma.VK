import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct RequestMainProfile: Codable {
    let response: [MainProfile]
}

// MARK: - Response
struct MainProfile: Codable {
    let id: Int
    let firstName, lastName: String
    let sex: Int
    let nickname: String
    let maidenName: String?
    let domain, screenName: String
    let bdate: String
    let city, country: City
    let timezone: Int
    let photo50, photo100, photo200, photoMax: String
    let photo200_Orig, photo400_Orig, photoMaxOrig: String
    let photoID: String
    let hasPhoto, hasMobile, isFriend, friendStatus: Int
    let online, canPost, canSeeAllPosts, canSeeAudio: Int
    let canWritePrivateMessage, canSendFriendRequest: Int
    let mobilePhone, homePhone, site, status: String
    let lastSeen: LastSeen
    let cropPhoto: CropPhoto
    let verified: Int
    let canBeInvitedGroup: Bool
    let followersCount, blacklisted, blacklistedByMe, isFavorite: Int
    let isHiddenFromFeed, commonCount: Int
    let occupation: Occupation?
    let career, military: [JSONAny]
    let university: Int
    let universityName: String
    let faculty: Int
    let facultyName: String
    let graduation: Int
    let homeTown: String
    let relation: Int
    let personal: Personal
    let interests, music, activities, movies: String
    let tv, books, games: String
    let universities: [University]
    let schools: [School]
    let about: String
    let relatives: [Relative]
    let quotes: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case sex, nickname
        case maidenName = "maiden_name"
        case domain
        case screenName = "screen_name"
        case bdate, city, country, timezone
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
        case canPost = "can_post"
        case canSeeAllPosts = "can_see_all_posts"
        case canSeeAudio = "can_see_audio"
        case canWritePrivateMessage = "can_write_private_message"
        case canSendFriendRequest = "can_send_friend_request"
        case mobilePhone = "mobile_phone"
        case homePhone = "home_phone"
        case site, status
        case lastSeen = "last_seen"
        case cropPhoto = "crop_photo"
        case verified
        case canBeInvitedGroup = "can_be_invited_group"
        case followersCount = "followers_count"
        case blacklisted
        case blacklistedByMe = "blacklisted_by_me"
        case isFavorite = "is_favorite"
        case isHiddenFromFeed = "is_hidden_from_feed"
        case commonCount = "common_count"
        case occupation, career, military, university
        case universityName = "university_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation
        case homeTown = "home_town"
        case relation, personal, interests, music, activities, movies, tv, books, games, universities, schools, about, relatives, quotes
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

// MARK: - CropPhoto
struct CropPhoto: Codable {
    let photo: Photo
    let crop, rect: Crop
}

// MARK: - Crop
struct Crop: Codable {
    let x, y, x2, y2: Double
}

// MARK: - Photo
struct Photo: Codable {
    let id, albumID, ownerID: Int
    let photo75, photo130, photo604, photo807: String
    let photo1280, photo2560: String
    let width, height: Int
    let text: String
    let date, postID: Int

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
    }
}

// MARK: - LastSeen
struct LastSeen: Codable {
    let time, platform: Int
}

// MARK: - Occupation
struct Occupation: Codable {
    let type: String
    let id: Int
    let name: String
}

// MARK: - Personal
struct Personal: Codable {
    let political: Int?
    let langs: [String]?
    let religion: String?
    let peopleMain, lifeMain, smoking, alcohol: Int?

    enum CodingKeys: String, CodingKey {
        case political, langs, religion
        case peopleMain = "people_main"
        case lifeMain = "life_main"
        case smoking, alcohol
    }
}

// MARK: - Relative
struct Relative: Codable {
    let id: Int
    let type: String
}

// MARK: - School
struct School: Codable {
    let id: String
    let country, city: Int
    let name: String
    let yearFrom, yearTo: Int
    let schoolClass: String
    let type: Int
    let typeStr: String

    enum CodingKeys: String, CodingKey {
        case id, country, city, name
        case yearFrom = "year_from"
        case yearTo = "year_to"
        case schoolClass = "class"
        case type
        case typeStr = "type_str"
    }
}

// MARK: - University
//struct University: Codable {
//    let id, country, city: Int
//    let name: String
//    let faculty: Int
//    let facultyName: String
//    let chair: Int
//    let chairName: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, country, city, name, faculty
//        case facultyName = "faculty_name"
//        case chair
//        case chairName = "chair_name"
//    }
//}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}



