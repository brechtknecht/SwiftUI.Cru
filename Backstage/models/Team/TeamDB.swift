//
//  TeamDB.swift
//  Backstage
//
//  Created by Felix Tesche on 31.05.21.
//

import Foundation
import RealmSwift

@objcMembers class TeamDB: Object {
    dynamic var partition   = "all-the-data"
    
    dynamic var id          = 0
    dynamic var _id         = 0
    dynamic var name        = ""
    dynamic var teamRef     = ""
    dynamic var adminID     = 0
    let members             = RealmSwift.List<UserDB>()
    let events              = RealmSwift.List<EventDB>()
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
