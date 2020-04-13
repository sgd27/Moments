//
//  TweetRow.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct TweetRow: View {
    var tweet: Tweet
    var body: some View {
        HStack(alignment: .top) {
            AvatarImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: tweet.sender!.avatar)))
            VStack(alignment: .leading) {
                Text(tweet.sender?.nick ?? "").font(.headline)
                Text(tweet.content ?? "").font(.body)
            }
        }
    }
}

struct imagesGrid: View {
    var imageUrls: [String]
    private let columns: Int
    
    var body: some View {
        
    }
}
