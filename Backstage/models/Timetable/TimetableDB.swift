//
//  TimetableDB.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import RealmSwift

@objcMembers class TimetableDB : Object {
    dynamic var _id            = 0
    dynamic var id            = 0
    let timeslots                   = RealmSwift.List<Int>()
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
