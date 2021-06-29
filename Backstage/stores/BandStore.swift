//
//  BandStore.swift
//  Backstage
//
//  Created by Felix Tesche on 25.05.21.
//

import Foundation
import RealmSwift

final class BandStore: ObservableObject {
    private var results: Results<BandDB>
    
    var bands: [Band] {
        results.map(Band.init)
    }
    
    init(realm: Realm) {
        results = realm.objects(BandDB.self)
    }
    

    func findByID (id: Int) -> BandDB! {
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            return try Realm(configuration: configuration).object(ofType: BandDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func findWithFixedPartitionValue (partitionValue: String) -> BandDB! {
        do {
            let partitionValue = "all-the-data"
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let predicate = NSPredicate(format: "bandRef = %@", partitionValue as String)
            
            return try Realm(configuration: configuration).objects(BandDB.self).filter(predicate).first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func findByPartitionValue (partitionValue: String) -> BandDB! {
        do {
            let partitionValue = "all-the-data"
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let predicate = NSPredicate(format: "bandRef = %@", partitionValue as String)
            
            return try Realm(configuration: configuration).objects(BandDB.self).filter(predicate).first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

}

// MARK: - CRUD Actions
extension BandStore {
    func create(bandID: Int, name: String, bandRef: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = BandDB()
            
            refDB.id = bandID
            refDB._id = bandID
            refDB.name = name
            refDB.bandRef = bandRef
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func addEvent(band: BandDB, event: EventDB? = nil) {
        if(event == nil)        { print("Cannot add Event to Band — event parameter was not provided"); return }
        if(band  == nil)        { print("Cannot add Event to Band — Previous Band was not found"); return}
        
        let previousBand = band
        
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            try realm.write {
                let updatedBand = BandDB()
                
                if(!previousBand.events.isEmpty){
                    updatedBand.events.append(objectsIn: previousBand.events)
                }
                updatedBand.events.append(event!)
                
                realm.create(BandDB.self,
                     value: [
                        "_id"     : band.id,
                        "id"      : band._id,
                        "events"  : updatedBand.events
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
}

