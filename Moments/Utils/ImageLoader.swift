//
//  ImageLoader.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/13.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import UIKit

public class ImageLoaderCache {
    public static let shared = ImageLoaderCache()

    private var loaders: NSCache<NSString, ImageLoader> = NSCache()

    public func loaderFor(url: URL?) -> ImageLoader {
        let key = NSString(string: "\(url?.absoluteString ?? "missing")")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let loader = ImageLoader(url: url)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}

public final class ImageLoader: ObservableObject {
    public let url: URL?

    public var objectWillChange: AnyPublisher<UIImage?, Never> = Publishers
        .Sequence<[UIImage?], Never>(sequence: []).eraseToAnyPublisher()

    @Published public var image: UIImage?

    public var cancellable: AnyCancellable?

    public init(url: URL?) {
        self.url = url

        objectWillChange = $image.handleEvents(receiveSubscription: { [weak self] _ in
            self?.loadImage()
        }, receiveCancel: { [weak self] in
            self?.cancellable?.cancel()
        }).eraseToAnyPublisher()
    }

    private func loadImage() {
        guard let imageUrl = url, image == nil else {
            return
        }
        cancellable = ImageService.shared.fetchImage(url: imageUrl)
            .receive(on: DispatchQueue.main)
            .assign(to: \ImageLoader.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
