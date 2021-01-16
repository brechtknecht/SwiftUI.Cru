//
//  Event.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import SwiftUI
import RealmSwift

struct Event: Identifiable, Hashable {
    let id              : Int
    let name            : String
    let date            : Date
    let venueID         : Int
    let imageUUID       : String
    let settlements     : RealmSwift.List<Int>
    let transports      : RealmSwift.List<Int>
    let fee             : Int
    let type            : String
}

extension Event {
    init(eventDB: EventDB) {
        id                  = eventDB.id
        name                = eventDB.name
        date                = eventDB.date
        venueID             = eventDB.venueID
        imageUUID           = eventDB.imageUUID
        settlements         = eventDB.settlements
        transports          = eventDB.transports
        fee                 = eventDB.fee
        type                = eventDB.type
    }
}
