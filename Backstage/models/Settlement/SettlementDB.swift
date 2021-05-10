//
//  SettlementDB.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import RealmSwift
import SwiftUI

class SettlementDB: Object {
    @objc dynamic var _id = 0
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var location = ""
    @objc dynamic var arrivalDate = Date()
    @objc dynamic var departureDate = Date()
    @objc dynamic var price = 0
    @objc dynamic var currency = "€"
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "_id"
    }
}

