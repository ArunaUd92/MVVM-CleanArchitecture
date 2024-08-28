//
//  APIService.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Alamofire
import Combine
import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = APIConfig.baseURL
    private var token = APIConfig.apiToken // Mutable to update access token
    private let refresh_Token = APIConfig.refreshToken // Refresh token

    // Alamofire Session with Retry Policy
    private let session: Session = {
        let retryPolicy = RetryPolicy(retryLimit: 3, exponentialBackoffBase: 2)
        return Session(interceptor: retryPolicy)
    }()

    private init() {}

    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil) -> AnyPublisher<T, Error> {
        let url = "\(baseURL)\(endpoint)"
        return executeRequest(url: url, method: method, parameters: parameters)
            .flatMap { (response: T) -> AnyPublisher<T, Error> in
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .catch { error -> AnyPublisher<T, Error> in
                if case let apiError as APIError = error, apiError.message == "token_expired" {
                    return self.refreshToken()
                        .flatMap { _ in
                            self.executeRequest(url: url, method: method, parameters: parameters)
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func executeRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<T, Error> {
        let headers: HTTPHeaders = [
          //  "Authorization": "Bearer \(token)"
        ]

        return Future { promise in
            self.session.request(url, method: method, parameters: parameters, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        if let data = response.data {
                            let apiError = try? JSONDecoder().decode(APIError.self, from: data)
                            promise(.failure(apiError ?? error))
                        } else {
                            promise(.failure(error))
                        }
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    private func refreshToken() -> AnyPublisher<Void, Error> {
        let url = "\(baseURL)/refresh-token" // Adjust endpoint as needed
        let parameters: Parameters = ["refresh_token": refresh_Token]
        
        return Future { promise in
            self.session.request(url, method: .post, parameters: parameters)
                .validate()
                .responseDecodable(of: TokenResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        self.token = data.accessToken // Update the token
                        promise(.success(()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

// Retry Policy Interceptor
class RetryPolicy: RequestInterceptor {
    private let retryLimit: Int
    private let exponentialBackoffBase: TimeInterval

    init(retryLimit: Int, exponentialBackoffBase: TimeInterval) {
        self.retryLimit = retryLimit
        self.exponentialBackoffBase = exponentialBackoffBase
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let retryCount = request.retryCount

        if retryCount < retryLimit {
            let delay = exponentialBackoffBase * pow(2.0, Double(retryCount))
            completion(.retryWithDelay(delay))
        } else {
            completion(.doNotRetry)
        }
    }
}

struct APIError: Decodable, Error {
    let message: String
}

struct TokenResponse: Decodable {
    let accessToken: String
}

