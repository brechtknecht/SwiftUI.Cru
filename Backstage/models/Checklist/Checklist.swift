
//
//  Checklist.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import SwiftUI
import RealmSwift

@objcMembers class ChecklistItem : Object {
    dynamic var _id                 = 0
    dynamic var id                  = 0
    dynamic var label               = ""
    dynamic var isDone              = false
    dynamic var assignedUser        : UserDB? = UserDB()
    
    override static func primaryKey() -> String? {
        "_id"
    }
}



struct Checklist: Identifiable, Hashable, Equatable {
    let _id         : Int
    let id          : Int
    let name        : String
    let items       : RealmSwift.List<ChecklistItem>
}

extension Checklist {
    init(ChecklistDB: ChecklistDB) {
        _id             = ChecklistDB._id
        id              = ChecklistDB.id
        name            = ChecklistDB.name
        items           = ChecklistDB.items
    }
}

