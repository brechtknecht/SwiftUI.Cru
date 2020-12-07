//
//  EventDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

class EventDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var venueID = 0
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "id"
    }
}
