//
//  MockUserFetchDelegate.swift
//  MVVM+CleanArchitectureTests
//
//  Created by Aruna Udayanga on 23/07/2024.
//

@testable import MVVM_CleanArchitecture

class MockUserFetchDelegate: UserFetchDelegate {
    var selectedUser: User?
    var fetchedUsers: [User] = []
    var fetchError: Error?

    func didFetchUsers(users: [User]) {
        fetchedUsers = users
    }

    func didFailWithError(error: Error) {
        fetchError = error
    }

    func didSelectUser(user: User) {
        selectedUser = user
    }
}
