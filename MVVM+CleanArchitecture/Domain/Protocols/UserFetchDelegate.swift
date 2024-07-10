//
//  Protocols.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 10/07/2024.
//

protocol UserFetchDelegate: AnyObject {
    func didFetchUsers(users: [User])
    func didFailWithError(error: Error)
    func didSelectUser(user: User)
}
