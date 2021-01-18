//
//  TimetableDB.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import RealmSwift

class TimetableDB : Object {
    @objc dynamic var id            = 0
    let timeslots                   = RealmSwift.List<Int>()
    
    override static func primaryKey() -> String? {
        "id"
    }
}
