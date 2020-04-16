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
                    .frame(width: 55, height: 55)
                    .cornerRadius(8)

            } else {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 55, height: 55)
                    .cornerRadius(8)
            }
        }
    }
}
