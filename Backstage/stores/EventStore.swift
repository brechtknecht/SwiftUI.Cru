//
//  EventStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

final class EventStore: ObservableObject {
    private var results: Results<EventDB>
    
    var events: [Event] {
        results.map(Event.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(EventDB.self)
    }
}

// MARK: - CRUD Actions
extension EventStore {
    func create(name: String, date: Date, venueID: Int) {
        
        objectWillChange.send()

        do {
          let realm = try Realm()

          let refDB = EventDB()
          refDB.id = UUID().hashValue
          refDB.name = name
          refDB.date = date
          refDB.venueID = venueID

          try realm.write {
            realm.add(refDB)
          }
        } catch let error {
          // Handle error
          print(error.localizedDescription)
        }
    }
    
}
