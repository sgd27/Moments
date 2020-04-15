//
//  NavigationConfigurator.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context _: UIViewControllerRepresentableContext<NavigationConfigurator>)
        -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context _: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) {
        if let navigationController = uiViewController.navigationController {
            configure(navigationController)
        }
    }
}

struct NavigationConfigurator_Previews: PreviewProvider {
    static var previews: some View {
        NavigationConfigurator()
    }
}
