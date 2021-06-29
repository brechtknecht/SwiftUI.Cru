//
//  BandDB.swift
//  Backstage
//
//  Created by Felix Tesche on 31.05.21.
//

import Foundation
import RealmSwift

@objcMembers class BandDB: Object {
    dynamic var partition   = ""
    
    dynamic var id          = 0
    dynamic var _id         = 0
    dynamic var name        = ""
    dynamic var bandRef     = ""
    dynamic var adminID     = 0
    let members     = LinkingObjects(fromType: UserDB.self, property: "bands")
    let events      = RealmSwift.List<EventDB>()
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
