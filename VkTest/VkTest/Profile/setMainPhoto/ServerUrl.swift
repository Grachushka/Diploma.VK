//
//  getServerUrl.swift
//  VkTest
//
//  Created by Pavel Procenko on 08.11.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct ServerUrl: Codable {
    let response: ResponseServerUrl
}

struct ResponseServerUrl: Codable {
    let uploadURL: String

    enum CodingKeys: String, CodingKey {
        case uploadURL = "upload_url"
    }
}
