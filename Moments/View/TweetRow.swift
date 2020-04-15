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
            AvatarImage(
                imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: tweet.sender!.avatar)))
            VStack(alignment: .leading) {
                Text(tweet.sender?.nick ?? "").font(.headline)
                Text(tweet.content ?? "").font(.body)
                ImagesGrid(imageUrls: tweet.images?.map { $0.url } ?? [])
            }
        }
    }
}

// struct ImagesRow: View {
//    var imageUrls: [String]
//    var body: some View {
//        HStack {
//            ForEach(imageUrls, id: \.self) { url in
//                PostImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: url)))
//            }
//        }
//    }
// }

struct ImagesGrid: View {
    var imageUrls: [String]
    private struct Index: Identifiable { var id: Int }
    var body: some View {
        let count = imageUrls.count
        let columnCount: Int = count == 4 ? 2 : 3
        let rowCount: Int = count / columnCount + 1
        return VStack {
            ForEach((0 ..< rowCount).map { Index(id: $0) }) { row in
                HStack {
                    ForEach(
                        (0 ..< (row.id == rowCount - 1 ? count % columnCount : columnCount)).map { Index(id: $0) }
                    ) { column in
                        PostImage(
                            imageLoader: ImageLoaderCache.shared.loaderFor(
                                url: URL(string: self.imageUrls[row.id * columnCount + column.id])))
                    }
                }
            }
        }
    }
}

struct PostImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        Group {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 50, height: 50)

            } else {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct TweetRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!") /*@END_MENU_TOKEN@*/
    }
}
