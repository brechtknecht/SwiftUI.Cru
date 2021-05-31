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
            let partitionValue = realmSync.getPartitionValue()
            
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
    func create(name: String, bandRef: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = BandDB()
            
            let id = UUID().hashValue
            refDB.id = id
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
    
    
    // Updated eine gegebene Task. Dafür wird die ID benötigt,
    // welche in der Datenbank danach sucht und dann nach den mitgegebenen
    // Parametern aktualisiert.
    /// text und isDone sind hierbei optional
    func update(taskID: Int, text: String? = nil, isDone: Bool? = nil) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        let previousTask = self.findByID(id: taskID)!
                
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
//            try realm.write {
//                let updatedTask = TaskDB()
//                updatedTask.id     = taskID
//
//                if(text == nil) {
//                    updatedTask.task = previousTask.task
//                } else {
//                    updatedTask.task = text!
//                }
//
//                if(isDone == nil) {
//                    updatedTask.isDone = previousTask.isDone
//                } else {
//                    updatedTask.isDone = isDone!
//                }
//
//                updatedTask.isDone = isDone ?? false
//
//                realm.add(updatedTask, update: .modified)
//            }
            
        } catch let err {
            print(err.localizedDescription)
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

