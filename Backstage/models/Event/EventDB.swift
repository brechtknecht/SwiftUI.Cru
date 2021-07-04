//
//  EventDB.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI
import Combine

class EventDB: Object, ObjectKeyIdentifiable {
    @objc dynamic var partition             = "all-the-data"
    @objc dynamic var _id                   = 0
    @objc dynamic var id                    = 0
    @objc dynamic var name                  = ""
    @objc dynamic var date                  = Date()
    @objc dynamic var venueID               = 0
    @objc dynamic var imageUUID             = ""
    @objc dynamic var imageData             = Data()
    @objc dynamic var backgroundColorHex    = ""
    let attendants            = RealmSwift.List<UserDB>()
    @objc dynamic var timetable             = 0
    @objc dynamic var fee                   = 0
    @objc dynamic var type                  = ""    
    
    private let assignedTeams = LinkingObjects(fromType: TeamDB.self, property: "events")
    var assignedTeam: TeamDB {
        return self.assignedTeams.first ?? TeamDB()
    }
    
    let transports                          = RealmSwift.List<Int>( )
    
    let settlements                         = RealmSwift.List<SettlementDB>()
    let persons                             = RealmSwift.List<PersonDB>()
    let checklists                          = RealmSwift.List<ChecklistDB>()
    
    // Defines the standard key — realm needs this for identication
    override static func primaryKey() -> String? {
        "_id"
    }
}
