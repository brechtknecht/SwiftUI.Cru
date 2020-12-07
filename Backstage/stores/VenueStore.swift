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
    
    func update(venueID: Int, venueName: String, venueLocation: String, venueDistrict: String, venueCountry: String) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(VenueDB.self,
                value: [
                    VenueDBKeys.id.rawValue: venueID,
                    VenueDBKeys.name.rawValue: venueName,
                    VenueDBKeys.location.rawValue: venueLocation,
                    VenueDBKeys.district.rawValue: venueDistrict,
                    VenueDBKeys.country.rawValue: venueCountry
                ],
                update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(venueID: Int) {
        // TODO: Add Realm delete code below
        
        // Delete Function is here (17:33)
        // https://www.youtube.com/watch?v=x3T_qyU9WhE
    }
}

