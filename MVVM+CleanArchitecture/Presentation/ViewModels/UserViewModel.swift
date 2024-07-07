//
//  UserViewModel.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Combine
import SwiftUI

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: IdentifiableError?

    private let userRepository: UserRepository
    private var cancellables: Set<AnyCancellable> = []

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        userRepository.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
