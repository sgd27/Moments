//
//  AppState.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Combine
import Foundation

struct AppState {
    var moments = Moments()
}

extension AppState {
    struct Moments {
        var loadingUser = false
        var userLoadingError: AppError?
        var user: User?

        var loadingTweets = false
        var tweetsLoadingError: AppError?
        var tweets: [Tweet] = []
    }
}
