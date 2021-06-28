//
//  Band.swift
//  Backstage
//
//  Created by Felix Tesche on 24.05.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct Band: Identifiable, Hashable {
    let partition   : String
    
    let id          : Int
    let _id         : Int
    let name        : String
    let bandRef     : String
    let adminID     : Int
    let events      : RealmSwift.List<EventDB>
}

extension Band {
    init(bandDB: BandDB) {
        partition   = bandDB.partition
        
        id          = bandDB.id
        _id         = bandDB._id
        name        = bandDB.name
        bandRef     = bandDB.bandRef
        adminID     = bandDB.adminID
        
        events      = bandDB.events
    }
}
