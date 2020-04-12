//
//  ImageService.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Combine
import Foundation
import UIKit

public class ImageService {
    public static let shared = ImageService()

    public func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, _) -> UIImage? in
                UIImage(data: data)
            }.catch { _ in
                Just(nil)
            }
            .eraseToAnyPublisher()
    }
}
