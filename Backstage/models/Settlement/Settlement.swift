//
//  Settlement.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import SwiftUI

struct Settlement: Identifiable, Hashable {
    let id : Int
    let name : String
    let location : String
    let arrivalDate : Date
    let departureDate : Date
    let price : Int
    let currency : String
}

extension Settlement {
    init(settlementDB: SettlementDB) {
        id              = settlementDB.id
        name            = settlementDB.name
        location        = settlementDB.location
        arrivalDate     = settlementDB.arrivalDate
        departureDate   = settlementDB.departureDate
        price           = settlementDB.price
        currency        = settlementDB.currency
    }
}

