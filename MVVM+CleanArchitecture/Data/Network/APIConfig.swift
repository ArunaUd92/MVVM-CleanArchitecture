//
//  APIConfig.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 26/06/2024.
//

import Foundation


struct APIConfig {
    static let baseURL = "https://jsonplaceholder.typicode.com/"

}

struct APIError: Decodable, Error {
    let message: String
}

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
