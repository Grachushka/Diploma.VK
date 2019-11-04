//
//  addFriend.swift
//  VkTest
//
//  Created by Pavel Procenko on 24.10.2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

struct AddFriend: Codable {
    let error: Errorr?
    let response: Int?
}

// MARK: - Error
struct Errorr: Codable {
    let errorCode: Int?
    let errorMsg: String?
    let requestParams: [RequestParam]?
    let captchaSid: String?
    let captchaImg: String?
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
        case requestParams = "request_params"
        case captchaSid = "captcha_sid"
        case captchaImg = "captcha_img"
    }
}

// MARK: - RequestParam
struct RequestParam: Codable {
    let key, value: String?
}
