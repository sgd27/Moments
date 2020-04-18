//
//  NetImage.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/19.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct NetImage: View {
    var url: URL?
    var body: some View {
        LoadableImage(
            imageLoader: ImageLoaderCache.shared.loaderFor(url: url)
        )
    }
}

struct LoadableImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        Group {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
            } else {
                Rectangle()
                    .foregroundColor(.gray).opacity(0.1)
            }
        }
    }
}

struct NetImage_Previews: PreviewProvider {
    static var previews: some View {
        NetImage(url: URL(string: "")!)
    }
}
