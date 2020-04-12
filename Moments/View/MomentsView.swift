//
//  ContentView.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/11.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI
import UIKit

struct MomentsView: View {
    var user: User
    @State var tweets: [Tweet] = []

    var cameraButton: some View {
        Button(action: { print("Take picture") }) {
            Image(systemName: "camera").resizable().foregroundColor(.primary)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ProfileImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: user.profileImage)))
                    .listRowInsets(EdgeInsets())
                    .padding(0)
                    .padding(.top, -100)
                HStack {
                    Spacer()
                    HStack {
                        Text(user.nick)
                        AvatarImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: self.user.avatar)))
                    }
                }.padding(.top, -40)

                ForEach(tweets.filter { $0.content != nil || $0.images != nil }) { item in
                    HStack {
                        AvatarImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: self.user.avatar)))
                        Text(item.content ?? "")
                    }
                }
            }
            .navigationBarTitle("朋友圈", displayMode: .inline)
            .navigationBarItems(trailing: cameraButton)
            .background(NavigationConfigurator { navigationController in
                navigationController.navigationBar.standardAppearance.configureWithTransparentBackground()

                       })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            APIService.shared.GET(endpoint: .tweets, params: nil) { (result: Result<[Tweet], APIService.APIError>) in
                switch result {
                case let .success(response):
                    self.tweets = response
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentsView(user: sampleUser)
    }
}
