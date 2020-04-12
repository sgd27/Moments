//
//  ProfileImage.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct ProfileImage: View {
    @ObservedObject var imageLoader: ImageLoader

    var body: some View {
        ZStack(alignment: .center) {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(height: 200)

            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 200)
            }
        }
    }
}
