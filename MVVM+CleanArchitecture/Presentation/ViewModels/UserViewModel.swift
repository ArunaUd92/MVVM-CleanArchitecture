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

    private let fetchUsersUseCase: FetchUsersUseCase
    private var cancellables: Set<AnyCancellable> = []
    weak var delegate: UserFetchDelegate?

    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    func fetchUsers() {
        isLoading = true
        errorMessage = nil

        fetchUsersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = IdentifiableError(message: error.localizedDescription)
                    self?.delegate?.didFailWithError(error: error)
                }
            } receiveValue: { [weak self] users in
                self?.users = users
                self?.delegate?.didFetchUsers(users: users)
            }
            .store(in: &cancellables)
    }

    func selectUser(_ user: User) {
        delegate?.didSelectUser(user: user)
    }
}
