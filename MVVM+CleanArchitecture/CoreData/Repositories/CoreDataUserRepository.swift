//
//  CoreDataUserRepository.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 03/08/2024.
//

import Combine
import CoreData

class CoreDataUserRepository: UserRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }

    func fetchUsers() -> AnyPublisher<[User], Error> {
        let request: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        
        return Future { promise in
            do {
                let results = try self.context.fetch(request)
                let users = results.map { User(id: Int($0.id), name: $0.name ?? "", email: $0.email ?? "") }
                promise(.success(users))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func saveUser(_ user: User) {
        let userEntity = UserDataEntity(context: context)
        userEntity.id = Int64(user.id)
        userEntity.name = user.name
        userEntity.email = user.email

        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error)")
        }
    }

    func saveUsers(_ users: [User]) {
        users.forEach { saveUser($0) }
    }
}
