//
//  MockUserRepository.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 23/07/2024.
//

import Foundation
import Combine
@testable import MVVM_CleanArchitecture

class MockUserRepository: UserRepository {
    var fetchUsersResult: Result<[User], Error> = .success([])

    func fetchUsers() -> AnyPublisher<[User], Error> {
        return fetchUsersResult.publisher.eraseToAnyPublisher()
    }
}
