//
//  Event.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation

struct Event: Identifiable, Hashable {
    let id: Int
    let name: String
    let date: Date
    let venueID: Int
}

extension Event {
    init(eventDB: EventDB) {
        id = eventDB.id
        name = eventDB.name
        date = eventDB.date
        venueID = eventDB.venueID
    }
}
