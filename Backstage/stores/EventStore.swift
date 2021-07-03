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
        var events = [Int]()
        
        if(realmSync.user.id != 0) {
            // Add all events saved in the user-data
            realmSync.user.teams.forEach { team in
                team.events.forEach { (event) in
                    events.append(event.id)
                }
            }
            
            return separated.filter("id IN %@", events).map(Event.init)
        } else {
            return [Event]()
        }
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        unsorted = realm.objects(EventDB.self)
        results = realm.objects(EventDB.self).sorted(byKeyPath: "date", ascending: true)
        separated = realm.objects(EventDB.self).sorted(byKeyPath: "date", ascending: true)
        
        separated = realm.objects(EventDB.self).sorted(byKeyPath: "date", ascending: true)
    }
    
    func findByID (id: Int) -> EventDB! {
        do {
            let partitionValue = "all-the-data"
            
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
    func create(id: Int, name: String, assignedTeam: TeamDB, date: Date, fee: Int, type: String, venueID: Int, imageUUID: String, backgroundColorHex: String) {
        
        objectWillChange.send()
        
        do {
            
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = EventDB()
            
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
            let partitionValue = "all-the-data"
            
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
            let partitionValue = "all-the-data"
            
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
    
    func addSettlementToList (eventID: Int, settlement: SettlementDB) {
        let event = self.findByID(id: eventID)
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                event?.settlements.append(settlement)
            }
        }
    }
    
    func addAttendant (event: EventDB? = nil, attendingUser: UserDB? = nil) {
        if(event == nil) { print("Cannot add Attendand to Event, event parameter was not provided");  return }
        if(attendingUser == nil) { print("Cannot add Attendand to Event — user parameter was not provided");  return }
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                event!.attendants.append(attendingUser!)
            }
        }
    }
    
    func removeAttendant (event: EventDB? = nil, attendingUser: UserDB? = nil) {
        if(event == nil) { print("Cannot remove Attendant from event: event parameter was not provided");  return }
        if(attendingUser == nil) { print("Cannot remove Attendant from event: user parameter was not provided");  return }
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try! Realm(configuration: configuration)
            try! realm.write {
                guard let index = event!.attendants.index(of: attendingUser!) else {
                    print("Cannot remove Attendant from event: index of attendant was not found in events attendants list")
                    return
                }
                
                event!.attendants.remove(at: index)
            }
        }
    }
    
    func addTransportToList (eventID: Int, transportID: Int) {
        let event = self.findByID(id: eventID)
        
        do {
            let partitionValue = "all-the-data"
            
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
            let partitionValue = "all-the-data"
            
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
