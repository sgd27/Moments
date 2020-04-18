//
//  AppError.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/18.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

enum AppError: Error {
    case networkingFailed(Error)
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case let .networkingFailed(error):
            return error.localizedDescription
        }
    }
}
