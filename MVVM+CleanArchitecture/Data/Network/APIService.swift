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
    private let token = APIConfig.apiToken

    private init() {}

    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil) -> AnyPublisher<T, Error> {
        let url = "\(baseURL)\(endpoint)"
        let headers: HTTPHeaders = [
           // "Authorization": "JWT \(token)"
        ]

        return Future { promise in
            AF.request(url, method: method, parameters: parameters, headers: headers)
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
}

struct APIError: Decodable, Error {
    let message: String
}
