//
//  UserCoordinator.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 10/07/2024.
//

import Foundation

class UserCoordinator: ObservableObject, UserFetchDelegate {
    @Published var selectedUser: User?
    @Published var isShowingDetailView = false
    
    func didFetchUsers(users: [User]) {
        // Handle successful user fetch if needed
        print("Successfully fetched users.")
    }

    func didFailWithError(error: Error) {
        // Handle error
        print("Failed to fetch users with error: \(error.localizedDescription)")
    }

    func didSelectUser(user: User) {
        self.selectedUser = user
        self.isShowingDetailView = true
    }
}
