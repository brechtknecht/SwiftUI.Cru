//
//  ChecklistDB.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import RealmSwift
import SwiftUI

class ChecklistDB: Object {
    @objc dynamic var _id = 0
    @objc dynamic var id = 0
    @objc dynamic var name  = ""
    let items = RealmSwift.List<ChecklistItem>()
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "_id"
    }
}

