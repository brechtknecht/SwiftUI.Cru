//
//  VenueForm.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation

class VenueForm: ObservableObject {
    @Published var name = ""
    @Published var location = ""
    @Published var district = ""
    @Published var country = ""
    
    var venueItemId: Int?
    
    var updating: Bool {
        venueItemId != nil
    }
    
    init() {}
    
    init(_ venue: Venue) {
        name = venue.name
        location = venue.location
        district = venue.district
        country = venue.country
    }
}
