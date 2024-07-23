//
//  User.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Foundation

struct User: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let email: String
    
    // Implement Equatable
        static func ==(lhs: User, rhs: User) -> Bool {
            return lhs.id == rhs.id && lhs.name == rhs.name && lhs.email == rhs.email
        }
}
