//
//  Timetable.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Timetable: Identifiable {
    let _id             : Int
    let id              : Int
    let timeslots       : RealmSwift.List<Int>
}

extension Timetable {
    init(timetableDB: TimetableDB) {
        _id         = timetableDB._id
        id          = timetableDB.id
        timeslots   = timetableDB.timeslots
    }
}
