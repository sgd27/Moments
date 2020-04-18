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
    @State var pullStatus: CGFloat = 0
    let action: () -> Void
    let content: () -> Content

    init(action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }

    var body: some View {
        List {
            PullToRefreshView(showRefreshView: $showRefreshView, pullStatus: $pullStatus)
            self.content()
        }
        .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
            if values.count > 0 {
                let originY = values.map { $0.bounds.origin.y }.max()!
                self.pullStatus = CGFloat((originY - 80) / 50)
                self.refresh(offset: originY)
            }
        }
        .offset(x: 0, y: -40)
    }

    func refresh(offset: CGFloat) {
        if offset > 140, showRefreshView == false {
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
    @Binding var isRefresh: Bool
    @Binding var status: CGFloat
    var body: some View {
        HStack {
            Spacer()
            Circle().frame(width: 30, height: 30).foregroundColor(.red)
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

//        typealias Value = [PrefData]
    }
}

struct PullToRefreshView: View {
    @Binding var showRefreshView: Bool
    @Binding var pullStatus: CGFloat

    var body: some View {
        GeometryReader { geometry in
            RefreshView(isRefresh: self.$showRefreshView, status: self.$pullStatus)
                .opacity(Double((geometry.frame(in: .global).origin.y - 80) / 50))
                .preference(key: RefreshableKeyTypes.PrefKey.self,
                            value: [RefreshableKeyTypes.PrefData(bounds: geometry.frame(in: .global))])
                .offset(x: 0, y: -60)
        }
    }
}

// struct RefreshableList_Previews: PreviewProvider {
//    static var previews: some View {
////        RefreshableList(sho)
//    }
// }
