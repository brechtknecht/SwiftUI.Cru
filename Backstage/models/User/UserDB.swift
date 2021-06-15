//
//  UserDB.swift
//  Backstage
//
//  Created by Felix Tesche on 24.05.21.
//

import Foundation
import RealmSwift

@objcMembers class UserDB: Object {
    dynamic var partition = "all-the-users"
    
    dynamic var id      = 0
    dynamic var _id     = 0
    dynamic var name    = ""
    var bands = RealmSwift.List<BandDB>()
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
