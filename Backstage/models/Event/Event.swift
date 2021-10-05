//
//  Event.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import SwiftUI
import RealmSwift

struct Event: Identifiable {
    let partition           : String
    let _id                 : Int
    let id                  : Int
    let name                : String
    let date                : Date
    let assignedTeam        : TeamDB
    let venueID             : Int
    let imageUUID           : String
    let imageData           : Data
    let backgroundColorHex  : String
    let attendants          : RealmSwift.List<UserDB>
    let settlements         : RealmSwift.List<SettlementDB>
    let transports          : RealmSwift.List<Int>
    let persons             : RealmSwift.List<PersonDB>
    let checklists          : RealmSwift.List<ChecklistDB>
    let timetable           : Int
    let fee                 : Int
    let type                : String
}

extension Event {
    init(eventDB: EventDB) {
        partition           = eventDB.partition
        _id                 = eventDB._id
        id                  = eventDB.id
        assignedTeam        = eventDB.assignedTeam
        name                = eventDB.name
        date                = eventDB.date
        venueID             = eventDB.venueID
        imageUUID           = eventDB.imageUUID
        imageData           = eventDB.imageData
        backgroundColorHex  = eventDB.backgroundColorHex
        attendants          = eventDB.attendants
        settlements         = eventDB.settlements
        transports          = eventDB.transports
        persons             = eventDB.persons
        checklists          = eventDB.checklists
        timetable           = eventDB.timetable
        fee                 = eventDB.fee
        type                = eventDB.type
    }
}
