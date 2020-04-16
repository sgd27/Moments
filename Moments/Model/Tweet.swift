//
//  Tweet.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/12.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

// MARK: - Tweet

struct Tweet: Codable, Identifiable {
    var id: UUID { UUID() }
    let content: String?
    let images: [TweetImage]?
    let sender: Sender?
    let comments: [Comment]?
    let error, unknownError: String?

    enum CodingKeys: String, CodingKey {
        case content, images, sender, comments, error
        case unknownError = "unknown error"
    }
}

// MARK: - Comment

struct Comment: Codable, Identifiable {
    var id: UUID { UUID() }
    let content: String
    let sender: Sender
}

// MARK: - Sender

struct Sender: Codable {
    let username, nick: String
    let avatar: String
}

// MARK: - Image

struct TweetImage: Codable {
    let url: String
}
