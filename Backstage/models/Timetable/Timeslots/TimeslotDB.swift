//
//  TimeslotDB.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import RealmSwift

class TimeslotDB : Object {
    @objc dynamic var _id        = 0
    @objc dynamic var id        = 0
    @objc dynamic var startTime = Date()
    @objc dynamic var endTime   = Date()
    @objc dynamic var taskName  = ""
    
    override static func primaryKey() -> String? {
        "_id"
    }
}
