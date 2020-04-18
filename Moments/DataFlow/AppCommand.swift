//
//  AppCommand.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

protocol AppCommand {
    func execute(in store: Store)
}

struct LoadUserAppCommand: AppCommand {
    func execute(in store: Store) {
        APIService.shared.GET(endpoint: .user, params: nil) { (result: Result<User, APIService.APIError>) in
            switch result {
            case let .success(response):
                store.dispatch(.loadUserDone(result: .success(response)))
            case let .failure(error):
                store.dispatch(.loadUserDone(result: .failure(.networkingFailed(error))))
            }
        }
    }
}

struct LoadTweetsAppCommand: AppCommand {
    func execute(in store: Store) {
        APIService.shared.GET(endpoint: .tweets, params: nil) { (result: Result<[Tweet], APIService.APIError>) in
            switch result {
            case let .success(response):
                let validTweets = response.filter { $0.content != nil || $0.images != nil }
                store.dispatch(.loadTweetsDone(result: .success(validTweets)))
            case let .failure(error):
                store.dispatch(.loadTweetsDone(result: .failure(.networkingFailed(error))))
            }
        }
    }
}
