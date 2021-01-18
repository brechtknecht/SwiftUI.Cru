//
//  Timetable.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Timetable: Identifiable, Hashable {
    let id              : Int
    let timeslots       : RealmSwift.List<Int>
}

extension Timetable {
    init(timetableDB: TimetableDB) {
        id          = timetableDB.id
        timeslots   = timetableDB.timeslots
    }
}
