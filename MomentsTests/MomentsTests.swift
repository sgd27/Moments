//
//  MomentsTests.swift
//  MomentsTests
//
//  Created by 施国栋 on 2020/4/11.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation
import XCTest

@testable import Moments

class MomentsTests: XCTestCase {
    func testCallToUser() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let promise = expectation(description: "Completion handler invoked")
        var response: User?
        var apiError: APIService.APIError?

        APIService.shared.GET(endpoint: .user, params: nil) { (result: Result<User, APIService.APIError>) in
            switch result {
            case let .success(user):
                response = user
            case let .failure(error):
                apiError = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(response)
        XCTAssertNil(apiError)
    }
}
