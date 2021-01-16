//
//  PersonDB.swift
//  Backstage
//
//  Created by Felix Tesche on 16.01.21.
//

import Foundation
import RealmSwift

class PersonDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var role = ""
    @objc dynamic var phoneNumber = ""
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "id"
    }
}
