//
//  EventDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI
import Combine

class EventDB: Object, ObjectKeyIdentifiable {
    @objc dynamic var _id                   = 0
    @objc dynamic var id                    = 0
    @objc dynamic var name                  = ""
    @objc dynamic var date                  = Date()
    @objc dynamic var venueID               = 0
    @objc dynamic var imageUUID             = ""
    @objc dynamic var backgroundColorHex    = ""
    @objc dynamic var timetable             = 0
    @objc dynamic var fee                   = 0
    @objc dynamic var type                  = ""
    let settlements                         = RealmSwift.List<Int>()
    let transports                          = RealmSwift.List<Int>()
    let persons                             = RealmSwift.List<Int>()
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "_id"
    }
}
