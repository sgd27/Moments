//
//  Store.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Combine
import Foundation

class Store: ObservableObject {
    @Published var appState = AppState()

    func dispatch(_ action: AppAction) {
        print("[ACTION]: \(action)")
        let result = Store.reduce(state: appState, action: action)
        appState = result.0
        if let command = result.1 {
            print("[COMMAND]: \(command)")
            command.execute(in: self)
        }
    }

    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
        var appCommand: AppCommand?

        switch action {
        case .loadUser:
            if appState.moments.loadingUser {
                break
            }
            appState.moments.userLoadingError = nil
            appState.moments.loadingUser = true
            appCommand = LoadUserAppCommand()
        case let .loadUserDone(result):
            appState.moments.loadingUser = false
            switch result {
            case let .success(user):
                appState.moments.user = user
            case let .failure(error):
                appState.moments.userLoadingError = error
            }
        case .loadTweets:
            if appState.moments.loadingTweets {
                break
            }
            appState.moments.tweetsLoadingError = nil
            appState.moments.loadingTweets = true
            appCommand = LoadTweetsAppCommand()
        case let .loadTweetsDone(result):
            appState.moments.loadingTweets = false
            switch result {
            case let .success(tweets):
                appState.moments.tweets = tweets
            case let .failure(error):
                appState.moments.tweetsLoadingError = error
            }
        }
        return (appState, appCommand)
    }
}
