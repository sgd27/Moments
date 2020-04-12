//
//  AvatarImage.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct AvatarImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        Group {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 40, height: 40)

            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
    }
}
