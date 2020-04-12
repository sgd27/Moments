//
//  ContentView.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/11.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct MomentsView: View {
    var user: User

    var cameraButton: some View {
        Button(action: { print("Take picture") }) {
            Image(systemName: "camera").resizable().foregroundColor(.primary)
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ProfileImage(imageLoader: ImageLoaderCache.shared.loaderFor(url: URL(string: user.profileImage)))
                    .navigationBarTitle("朋友圈", displayMode: .inline).navigationBarItems(trailing: cameraButton)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentsView(user: sampleUser)
    }
}
