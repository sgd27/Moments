//
//  User.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/12.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

struct User: Codable {
    let profileImage: String
    let avatar: String
    let nick, username: String

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile-image"
        case avatar, nick, username
    }
}
