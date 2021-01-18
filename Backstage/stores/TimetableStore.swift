//
//  TimetableStore.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation
import RealmSwift
import SwiftUI

final class TimetableStore: ObservableObject {
    private var results: Results<TimetableDB>
    
    var timetables: [Timetable] {
        results.map(Timetable.init)
    }
    
    
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(TimetableDB.self)
    }
    
    
    
    func findByID (id: Int) -> TimetableDB! {
        do {
            return try Realm().object(ofType: TimetableDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension TimetableStore {
    func create(name: String) {
        objectWillChange.send()

        do {
          let realm = try Realm()

          let refDB = TimetableDB()
          refDB.id              = UUID().hashValue
            
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
                realm.create(TimetableDB.self,
                value: [
                    TimetableDBKeys.id.rawValue: venueID,
                    
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
            let realm = try Realm()
        
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

