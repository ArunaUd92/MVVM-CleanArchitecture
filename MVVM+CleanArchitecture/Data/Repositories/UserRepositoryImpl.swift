//
//  UserRepositoryImpl.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Foundation
import Combine

class UserRepositoryImpl: UserRepository {
    private let apiService = APIService.shared

    func fetchUsers() -> AnyPublisher<[User], Error> {
        let url = "users"
        return apiService.request(url)
    }
    
    func getUserData(userId: String) -> AnyPublisher<[User], Error> {
          return apiService.request("/free/\(userId)")
      }
}
