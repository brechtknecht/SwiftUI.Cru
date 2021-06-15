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
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            return try Realm(configuration: configuration).object(ofType: BandDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func findByPartitionValue (partitionValue: String) -> BandDB! {
        do {
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: "all-the-bands")
            
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
            let partitionValue = bandRef
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: "all-the-bands")
            
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
    
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
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

