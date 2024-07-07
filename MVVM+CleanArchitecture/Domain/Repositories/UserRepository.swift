//
//  UserRepository.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Foundation
import Combine

protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], Error>
}
