//
//  Transport.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import SwiftUI

struct Transport: Identifiable, Hashable {
    let id          : Int
    let name        : String
    let tag         : String
    let seats       : Int
    let type        : String
    let isRented    : Bool
    let price       : Int
}

extension Transport {
    init(transportDB: TransportDB) {
        id              = transportDB.id
        name            = transportDB.name
        tag             = transportDB.tag
        seats           = transportDB.seats
        type            = transportDB.type
        isRented        = transportDB.isRented
        price           = transportDB.price
    }
}

