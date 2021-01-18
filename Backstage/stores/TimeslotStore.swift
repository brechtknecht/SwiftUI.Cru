//
//  TimeslotStore.swift
//  Backstage
//
//  Created by Felix Tesche on 18.01.21.
//

import Foundation

import RealmSwift
import SwiftUI

final class TimeslotStore: ObservableObject {
    private var results: Results<TimeslotDB>
    
    var timeslots: [Timeslot] {
        results.map(Timeslot.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(TimeslotDB.self)
    }
    
    func findByID (id: Int) -> TimeslotDB! {
        do {
            return try Realm().object(ofType: TimeslotDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension TimeslotStore {
    func create(id: Int, startTime: Date, endTime: Date, taskName: String) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let refDB = TimeslotDB()
            refDB.id            = id
            refDB.startTime     = startTime
            refDB.endTime       = endTime
            refDB.taskName      = taskName
            

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
    
    func deleteWithID (id: Int) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let object = realm.objects(TimeslotDB.self).filter("id = %@", id).first
            
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

}
