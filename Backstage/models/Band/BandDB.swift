//
//  BandDB.swift
//  Backstage
//
//  Created by Felix Tesche on 31.05.21.
//

import Foundation
import RealmSwift

@objcMembers class BandDB: Object {
    dynamic var id          = 0
    dynamic var _id         = 0
    dynamic var name        = ""
    let members             = RealmSwift.List<Int>()
    dynamic var bandRef     = ""
    dynamic var adminID     = 0
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
