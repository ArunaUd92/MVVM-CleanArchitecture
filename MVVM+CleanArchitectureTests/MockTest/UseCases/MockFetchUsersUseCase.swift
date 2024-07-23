//
//  MockFetchUsersUseCase.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 23/07/2024.
//

import Foundation
import Combine
@testable import MVVM_CleanArchitecture

class MockFetchUsersUseCase: FetchUsersUseCase {
    var fetchUsersResult: Result<[User], Error> = .success([])

    func execute() -> AnyPublisher<[User], Error> {
        return fetchUsersResult.publisher.eraseToAnyPublisher()
    }
}
