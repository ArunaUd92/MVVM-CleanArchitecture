//
//  FetchUsersUseCase.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 09/07/2024.
//

import Foundation
import Combine

protocol FetchUsersUseCase {
    func execute() -> AnyPublisher<[User], Error>
}

class FetchUsersUseCaseImpl: FetchUsersUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute() -> AnyPublisher<[User], Error> {
        return userRepository.fetchUsers()
    }
}
