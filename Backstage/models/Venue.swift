//
//  Venue.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation

struct Venue: Identifiable {
    let id: Int
    let name: String
    let location: String
    let district: String
    let country: String
}

extension Venue {
    init(venueDB: VenueDB) {
        id = venueDB.id
        name = venueDB.name
        location = venueDB.location
        district = venueDB.district
        country = venueDB.country
    }
}
