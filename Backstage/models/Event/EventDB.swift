//
//  EventDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

class EventDB: Object {
    @objc dynamic var id            = 0
    @objc dynamic var name          = ""
    @objc dynamic var date          = Date()
    @objc dynamic var venueID       = 0
    @objc dynamic var imageUUID     = ""
    @objc dynamic var fee           = 0
    @objc dynamic var type          = ""
    let settlements                 = RealmSwift.List<Int>()
    let transports                  = RealmSwift.List<Int>()
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "id"
    }
}
