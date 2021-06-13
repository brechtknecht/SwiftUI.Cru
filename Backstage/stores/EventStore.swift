//
//  EventStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

final class EventStore: ObservableObject {
    private var results: Results<EventDB>
    private var unsorted: Results<EventDB>
    private var separated: Results<EventDB>
    
    var events: [Event] {
        results.map(Event.init)
    }
    
    var unsortedEvents: [Event] {
        unsorted.map(Event.init)
    }
    
    var separatedEvents: [Event] {
        separated.map(Event.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        unsorted = realm.objects(EventDB.self)
        results = realm.objects(EventDB.self).sorted(byKeyPath: "date", ascending: true)
        separated = realm.objects(EventDB.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func findByID (id: Int) -> EventDB! {
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            return try Realm(configuration: configuration).object(ofType: EventDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension EventStore {
    func create(name: String, date: Date, fee: Int, type: String, venueID: Int, imageUUID: String, backgroundColorHex: String) {
        
        objectWillChange.send()
        
        do {
            
            let partitionValue = realmSync.partitionValue
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = EventDB()
            
            let id = UUID().hashValue
            
            refDB._id                   = id
            refDB.id                    = id
            refDB.name                  = name
            refDB.date                  = date
            refDB.fee                   = fee
            refDB.type                  = type
            refDB.venueID               = venueID
            refDB.imageUUID             = imageUUID
            refDB.backgroundColorHex    = backgroundColorHex
            refDB.imageData             = self.convertImageToData(imageUUID: imageUUID)
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.partitionValue
            
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
    
    func deleteWithID (id: Int) {
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.partitionValue
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let object = realm.objects(EventDB.self).filter("id = %@", id).first
                        
            try! realm.write {
                if let obj = object {
                    realm.delete(obj)
                }
            }
        }
        catch let err {
            print(err.localizedDescription)
        }
    }
    
    func update(eventID: Int, name: String, date: Date, venueID: Int, imageUUID: String, settlements: RealmSwift.List<Int>) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(VenueDB.self,
                value: [
                    EventDBKeys.id.rawValue             : eventID,
                    EventDBKeys.date.rawValue           : name,
                    EventDBKeys.venueID.rawValue        : venueID,
                    EventDBKeys.imageUUID.rawValue      : imageUUID,
                    EventDBKeys.settlements.rawValue    : settlements
                ],
                update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func addSettlementToList (eventID: Int, settlementID: Int) {
        let event = self.findByID(id: eventID)
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                event?.settlements.append(settlementID)
            }
        }
    }
    
    func addTransportToList (eventID: Int, transportID: Int) {
        let event = self.findByID(id: eventID)
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                event?.transports.append(transportID)
            }
        }
    }
    
    func addPersonToList (eventID: Int, person: PersonDB) {
        let event = self.findByID(id: eventID)
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                event?.persons.append(person)
            }
        }
    }
    
    func convertImageToData(imageUUID: String) -> Data {
        let image = Utilities.helpers.loadImageFromUUID(imageUUID: imageUUID, compression: 0.0)
        let data = image.pngData()
        return data ?? Data.init()
    }
}
