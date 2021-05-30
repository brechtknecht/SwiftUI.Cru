//
//  UserDB.swift
//  Backstage
//
//  Created by Felix Tesche on 24.05.21.
//

import Foundation
import RealmSwift

@objcMembers class UserDB: Object {
    dynamic var id      = 0
    dynamic var _id     = 0
    dynamic var name    = ""
    dynamic var bandRef  = ""
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
