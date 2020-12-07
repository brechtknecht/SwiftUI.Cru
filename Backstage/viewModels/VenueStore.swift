//
//  VenueStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

final class VenueStore: ObservableObject {
    private var results: Results<VenueDB>
    
    var venues: [Venue] {
        results.map(Venue.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(VenueDB.self)
    }
}

// MARK: - CRUD Actions
extension VenueStore {
    func create(name: String, location: String, district: String, country: String) {
        
        objectWillChange.send()

        do {
          let realm = try Realm()

          let refDB = VenueDB()
          refDB.id = UUID().hashValue
          refDB.name = name
          refDB.location = location
          refDB.district = district
          refDB.country = country

          try realm.write {
            realm.add(refDB)
          }
        } catch let error {
          // Handle error
          print(error.localizedDescription)
        }
    }
    
    func toggleBought(venue: Venue) {
        // TODO: Add Realm update code below
    }
    
    func update(venue: Venue) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(VenueDB.self,
                value: [
                    VenueDBKeys.id.rawValue: venue.id,
                    VenueDBKeys.name.rawValue: venue.name,
                    VenueDBKeys.location.rawValue: venue.location,
                    VenueDBKeys.district.rawValue: venue.district,
                    VenueDBKeys.country.rawValue: venue.country
                ],
                update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(venueID: Int) {
        // TODO: Add Realm delete code below
    }
}

