//
//  UserDataEntity+CoreDataProperties.swift
//  MVVM+CleanArchitecture
//
//  Created by Aruna Udayanga on 03/08/2024.
//
//

import Foundation
import CoreData


extension UserDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDataEntity> {
        return NSFetchRequest<UserDataEntity>(entityName: "UserDataEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}

extension UserDataEntity : Identifiable {

}
