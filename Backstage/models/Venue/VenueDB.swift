//
//  VenueDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import CoreLocation

class VenueDB: Object {
    @objc dynamic var _id: Int = 0
    @objc dynamic var band_id: String? = nil
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var location = ""
    @objc dynamic var street = ""
    @objc dynamic var country = ""
    
    
    
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "id"
    }
}
