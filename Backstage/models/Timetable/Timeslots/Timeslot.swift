//
//  Timeslots.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Timeslot: Identifiable, Hashable {
    let _id         : Int
    let id          : Int
    let startTime   : Date
    let endTime     : Date
    let taskName    : String
}

extension Timeslot {
    init(timeslotDB: TimeslotDB) {
        _id         = timeslotDB._id
        id          = timeslotDB.id
        startTime   = timeslotDB.startTime
        endTime     = timeslotDB.endTime
        taskName    = timeslotDB.taskName
    }
}
