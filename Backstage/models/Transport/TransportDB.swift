//
//  TransportDB.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import RealmSwift
import SwiftUI

class TransportDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var tag = ""
    @objc dynamic var seats = 0
    @objc dynamic var type = ""
    @objc dynamic var isRented = false
    @objc dynamic var price = 0
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "id"
    }
}

