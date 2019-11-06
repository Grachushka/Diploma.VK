//
//  Follower.swift
//  VkTest
//
//  Created by Pavel Procenko on 27.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct ResultResponseFollower: Codable {
    let response: ResponseFollower?
}

// MARK: - Response
struct ResponseFollower: Codable {
    let count: Int?
    let items: [Follower]?
}

// MARK: - Item
struct Follower: Codable, SecondElementProtocol {
    let id: Int?
    let firstName, lastName: String?
    let isClosed, canAccessClosed: Bool?
    let photo200: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo200 = "photo_200"
    }
}
