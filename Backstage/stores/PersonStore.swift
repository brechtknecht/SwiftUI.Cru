//
//  PersonStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

final class PersonStore: ObservableObject {
    private var results: Results<PersonDB>
    
    var persons: [Person] {
        results.map(Person.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(PersonDB.self)
    }
    
    func findByID (id: Int) -> PersonDB! {
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            return try Realm(configuration: configuration).object(ofType: PersonDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension PersonStore {
    func create(id: Int, name: String, role: String, phoneNumber: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = PersonDB()
            refDB.id            = id
            refDB._id           = id
            refDB.name          = name
            refDB.role          = role
            refDB.phoneNumber   = phoneNumber

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
            
            let object = realm.objects(PersonDB.self).filter("id = %@", id).first
            
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
