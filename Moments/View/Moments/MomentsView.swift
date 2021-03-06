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

    private func refresh() {
        page = 1
    }

    private func loadMore() {
        if page * 5 < tweets.count {
            page += 1
        }
    }

    var cameraButton: some View {
        Button(action: { print("Take picture") }) {
            Image(systemName: "camera").resizable().foregroundColor(.primary)
        }
    }

    var body: some View {
        NavigationView {
            RefreshableList(action: {
                self.refresh()
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
                    self.loadMore()
                }) {
                    HStack {
                        Spacer()
                        Text("\(self.page * 5 < self.tweets.count ? "加载更多" : "已经没有了")").font(.footnote)
                        Spacer()
                    }
                }
                .onAppear {
                    self.loadMore()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("朋友圈", displayMode: .inline)
            .navigationBarItems(trailing: cameraButton)
        }
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
                NetImage(url: URL(string: self.user.profileImage))
                    .frame(height: 300)
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fill)
                Spacer().frame(height: 20)
            }
            //                    .padding(.top, -30).edgesIgnoringSafeArea(.top)
            HStack {
                Spacer()
                HStack {
                    Text(self.user.nick)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    NetImage(url: URL(string: self.user.avatar))
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(8)
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
