//
//  VenueStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

import CoreLocation

final class VenueStore: ObservableObject {
    private var results: Results<VenueDB>
    
    var venues: [Venue] {
        results.map(Venue.init)
    }
    
    
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(VenueDB.self)
    }
    
    
    
    func findByID (id: Int) -> VenueDB! {
        do {
            return try Realm().object(ofType: VenueDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension VenueStore {
    func create(name: String, location: String, street: String, country: String) {
        
        objectWillChange.send()
        
        do {
            
            let partitionValue = RealmSync.partitionValue
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = VenueDB()
            
            let id = UUID().hashValue
            refDB._id = id
            refDB.id = id
            refDB.band_id = partitionValue
            refDB.name = name
            refDB.location = location
            refDB.street = street
            refDB.country = country
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func update(venueID: Int, venueName: String, venueLocation: String, venueStreet: String, venueCountry: String) {
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
                                VenueDBKeys.street.rawValue: venueStreet,
                                VenueDBKeys.country.rawValue: venueCountry
                             ],
                             update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let partitionValue = RealmSync.partitionValue
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            indexSet.forEach ({ index in
                try! realm.write {
                    realm.delete(self.results[index])
                }
            })
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

