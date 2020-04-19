//
//  RefreshableList.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct RefreshableList<Content: View>: View {
    @State var showRefreshView: Bool = false
    let action: () -> Void
    let content: () -> Content

    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }

    var body: some View {
        List {
            PullToRefreshView()
            self.content()
        }
        .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
            if values.count > 0 {
                let originY = values.map { $0.bounds.origin.y }.max()!
                self.refresh(offset: originY)
            }
        }
        .offset(x: 0, y: -40)
    }

    func refresh(offset: CGFloat) {
        if offset > 160, showRefreshView == false {
            showRefreshView = true
            DispatchQueue.main.async {
                self.action()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.showRefreshView = false
                }
            }
        }
    }
}

struct RefreshView: View {
    var body: some View {
        HStack {
            Spacer()
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
            Spacer()
        }
    }
}

struct RefreshableKeyTypes {
    struct PrefData: Equatable {
        let bounds: CGRect
    }

    struct PrefKey: PreferenceKey {
        static var defaultValue: [PrefData] = []
        static func reduce(value: inout [RefreshableKeyTypes.PrefData],
                           nextValue: () -> [RefreshableKeyTypes.PrefData]) {
            value.append(contentsOf: nextValue())
        }
    }
}

struct PullToRefreshView: View {
    var body: some View {
        GeometryReader { geometry in
            RefreshView()
                .opacity(Double((geometry.frame(in: .global).origin.y - 80) / 50))
                .preference(key: RefreshableKeyTypes.PrefKey.self,
                            value: [RefreshableKeyTypes.PrefData(bounds: geometry.frame(in: .global))])
                .offset(x: 0, y: -60)
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

// struct RefreshableList_Previews: PreviewProvider {
//    static var previews: some View {
////        RefreshableList(sho)
//    }
// }
