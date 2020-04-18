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
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 10) {
                AvatarImage(
                    imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: tweet.sender?.avatar ?? "")))
                VStack(alignment: .leading, spacing: 10) {
                    Text(tweet.sender?.nick ?? "")
                        .font(.headline)
                        .foregroundColor(Color("gray_blue", bundle: nil))
                    if tweet.content != nil {
                        Text(tweet.content ?? "").font(.body)
                    }
                    ImagesGrid(imageUrls: tweet.images?.map { $0.url } ?? [])
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            HStack(spacing: 4) {
                                Circle().fill(Color("gray_blue", bundle: nil)).frame(width: 4, height: 4)
                                Circle().fill(Color("gray_blue", bundle: nil)).frame(width: 4, height: 4)
                            }
                            .padding(.all, 5)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(2)
                        }
                    }
                    if (tweet.comments?.count ?? 0) > 0 {
                        CommentSection(comments: tweet.comments ?? [])
                    }
                }
                .padding(.leading, 5)
            }
            .padding(.horizontal, 10)

            Divider()
        }
        .padding(.top, 16)
    }
}

struct CommentSection: View {
    var comments: [Comment]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(comments) { comment in
                HStack {
                    Text("\(comment.sender.nick):")
                        .font(.footnote)
                        .foregroundColor(Color("gray_blue", bundle: nil))
                    Text(comment.content).font(.footnote)
                    Spacer()
                }
            }
        }
        .padding(.all, 5)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(4)
    }
}

struct ImagesGrid: View {
    var imageUrls: [String]
    private struct Index: Identifiable { var id: Int }
    var body: some View {
        let count = imageUrls.count
        let columnCount: Int = count == 4 ? 2 : 3
        let rowCount: Int = count / columnCount + 1
        let aspectRatio: CGFloat? = count > 1 ? 1 : nil
        let maxWidth: CGFloat? = count == 4 ? 100 : count > 1 ? 80 : 200
        return VStack(spacing: 3) {
            ForEach((0 ..< rowCount).map { Index(id: $0) }) { row in
                HStack(spacing: 3) {
                    ForEach(
                        (0 ..< (row.id == rowCount - 1 ? count % columnCount : columnCount)).map { Index(id: $0) }
                    ) { column in
                        PostImage(
                            imageLoader: ImageLoaderCache.shared.loaderFor(
                                url: URL(string: self.imageUrls[row.id * columnCount + column.id]))
                        )
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .frame(maxWidth: maxWidth)
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

            } else {
                Rectangle()
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: 200, maxHeight: 200)
    }
}

struct TweetRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!") /*@END_MENU_TOKEN@*/
    }
}
