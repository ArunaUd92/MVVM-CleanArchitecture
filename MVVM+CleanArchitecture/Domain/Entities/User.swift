//
//  User.swift
//  DestinyGuide
//
//  Created by Aruna Udayanga on 25/06/2024.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}
