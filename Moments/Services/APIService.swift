//
//  APIService.swift
//  Moments
//
//  Created by 施国栋 on 2020/4/12.
//  Copyright © 2020 施国栋. All rights reserved.
//

import Foundation

public struct APIService {
    let baseURL = URL(string: "YOUR URL")!
    public static let shared = APIService()
    let decoder = JSONDecoder()

    public enum APIError: Error {
        case noResponse
        case networkError(error: Error)
        case jsonDecodingError(error: Error)
    }

    public enum Endpoint {
        case user
        case tweets

        func path() -> String {
            switch self {
            case .user:
                return "user/jsmith"
            case .tweets:
                return "user/jsmith/tweets"
            }
        }
    }

    public func GET<T: Codable>(
        endpoint: Endpoint, params: [String: String]?,
        completionHandler: @escaping (Result<T, APIError>) -> Void
    ) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!

        if let params = params {
            for value in params {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    #if DEBUG
                        print("JSON DECODE Error: \(error)")
                    #endif
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
}
