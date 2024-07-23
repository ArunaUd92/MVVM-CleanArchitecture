//
//  UserViewModelTests.swift
//  MVVM+CleanArchitectureTests
//
//  Created by Aruna Udayanga on 23/07/2024.
//

import XCTest
import Combine
@testable import MVVM_CleanArchitecture

class UserViewModelTests: XCTestCase {
    private var viewModel: UserViewModel!
    private var mockFetchUsersUseCase: MockFetchUsersUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockFetchUsersUseCase = MockFetchUsersUseCase()
        viewModel = UserViewModel(fetchUsersUseCase: mockFetchUsersUseCase)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockFetchUsersUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        // Given
        let expectedUsers = [User(id: 1, name: "John Doe", email: "john.doe@example.com")]
        mockFetchUsersUseCase.fetchUsersResult = .success(expectedUsers)

        // When
        let expectation = self.expectation(description: "Users fetched successfully")
        viewModel.$users
            .dropFirst()
            .sink { users in
                // Then
                XCTAssertEqual(users, expectedUsers)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchUsers()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchUsersFailure() {
        // Given
        let expectedError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error fetching users"])
        mockFetchUsersUseCase.fetchUsersResult = .failure(expectedError)

        // When
        let expectation = self.expectation(description: "Error occurred while fetching users")
        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                // Then
                XCTAssertNotNil(error)
                XCTAssertEqual(error?.message, expectedError.localizedDescription)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchUsers()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testSelectUser() {
        // Given
        let user = User(id: 1, name: "John Doe", email: "john.doe@example.com")
        let mockDelegate = MockUserFetchDelegate()
        viewModel.delegate = mockDelegate

        // When
        viewModel.selectUser(user)

        // Then
        XCTAssertEqual(mockDelegate.selectedUser, user)
    }
}
