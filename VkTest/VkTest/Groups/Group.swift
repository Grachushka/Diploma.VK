//
//  Group.swift
//  VkTest
//
//  Created by Pavel Procenko on 29.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ResponseGroups: Codable {
    let response: ResponseGroup?
}

// MARK: - Response
struct ResponseGroup: Codable {
    
    let count: Int?
    let items: [Group]?
}

