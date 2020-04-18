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
    @EnvironmentObject var store: Store

    var user: User? { store.appState.moments.user }
    var tweets: [Tweet] { store.appState.moments.tweets }

    @State private var page: Int = 1

    var cameraButton: some View {
        Button(action: { print("Take picture") }) {
            Image(systemName: "camera").resizable().foregroundColor(.primary)
        }
    }

    var body: some View {
        NavigationView {
            RefreshableList(action: {
                self.page = 1
            }) {
                if self.user != nil {
                    UserProfile(user: self.user!)
                        .listRowInsets(EdgeInsets())
                }
                ForEach(self.tweets[0 ..< min(self.page * 5, self.tweets.count)]) { item in
                    TweetRow(tweet: item)
                        .listRowInsets(EdgeInsets())
                }
                Button(action: {
                    self.page += 1
                }) {
                    HStack {
                        Spacer()
                        Text("\(self.page * 5 <= self.tweets.count ? "加载更多" : "已经没有了")").font(.footnote)
                        Spacer()
                    }
                }
                .onAppear {
                    self.page += 1
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: cameraButton)
            .background(
                NavigationConfigurator { navigationController in
                    let navBar = navigationController.navigationBar
                    navBar.standardAppearance.configureWithTransparentBackground()
                    //                navigationBar.titleTextAttributes = [.foregroundColor: UIColor.]

            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.store.dispatch(.loadUser)
            self.store.dispatch(.loadTweets)
            UITableView.appearance().separatorColor = .clear
        }
    }
}

struct UserProfile: View {
    let user: User
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                ProfileImage(
                    imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: self.user.profileImage))
                ).scaledToFit().aspectRatio(1, contentMode: .fill)
                Spacer().frame(height: 40)
            }
            //                    .padding(.top, -30).edgesIgnoringSafeArea(.top)
            HStack {
                Spacer()
                HStack {
                    Text(self.user.nick)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    AvatarImage(
                        imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: self.user.avatar))
                    )
                    .scaledToFit()
                    .frame(width: 95, height: 95)
                    .aspectRatio(1, contentMode: .fill)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MomentsView().colorScheme(.light)
            //            MomentsView(user: sampleUser).colorScheme(.dark)
        }
    }
}
