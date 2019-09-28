//
//  ProfileProtocolVC.swift
//  VkTest
//
//  Created by Pavel Procenko on 28/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import Foundation

protocol ProfileProtocolVC {
    
    var id: Int {get}
    var firstName: String? {get}
    var lastName: String? {get}
    var photo200_Orig: String? {get}
    var online: Int {get}
    var lastSeen: LastSeen? {get}
    var city: City? {get}
    var country: City? {get}
    var isFriend: Int? {get}
}
