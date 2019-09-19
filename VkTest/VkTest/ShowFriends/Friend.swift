//
//  Friend.swift
//  VkTest
//
//  Created by Pavel Procenko on 14/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct Friend: Codable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String
    let photo100: String
    let photo200_Orig: String
    let online: Int
    let onlineApp: Int?
    let onlineMobile: Int?
    let deactivated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200_Orig = "photo_200_orig"
        case online
        case onlineApp = "online_app"
        case onlineMobile = "online_mobile"
        case deactivated
    }
}
