//
//  AppAction.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

enum AppAction {
    case loadUser
    case loadUserDone(result: Result<User, AppError>)
    case loadTweets
    case loadTweetsDone(result: Result<[Tweet], AppError>)
}
