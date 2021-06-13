//
//  VenueDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import CoreLocation

@objcMembers class VenueDB: Object, ObjectKeyIdentifiable {
    dynamic var _id = 0
    dynamic var id = 0
    dynamic var name = ""
    dynamic var location = ""
    dynamic var street = ""
    dynamic var country = ""
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "_id"
    }
}
