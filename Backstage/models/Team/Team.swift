//
//  Team.swift
//  Backstage
//
//  Created by Felix Tesche on 24.05.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Team: Identifiable, Hashable {
    let partition   : String
    
    let id          : Int
    let _id         : Int
    let name        : String
    let teamRef     : String
    let adminID     : Int
    let events      : RealmSwift.List<EventDB>
    let members     : RealmSwift.List<UserDB>
}

extension Team {
    init(teamDB: TeamDB) {
        partition   = teamDB.partition
        
        id          = teamDB.id
        _id         = teamDB._id
        name        = teamDB.name
        teamRef     = teamDB.teamRef
        adminID     = teamDB.adminID
        
        events      = teamDB.events
        members     = teamDB.members
    }
}
