//
//  TransportStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

final class UserStore: ObservableObject {
    private var results: Results<UserDB>
    
    var users: [User] {
        results.map(User.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(UserDB.self)
    }
    
    func findByID (id: Int) -> UserDB! {
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            return try Realm(configuration: configuration).object(ofType: UserDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension UserStore {
    func create(name: String, bandRef: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.getPartitionValue()
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = UserDB()
            let id = UUID().hashValue
            refDB.id            = id
            refDB._id           = id
            refDB.name          = name
            refDB.bandRef       = bandRef
            
            realmSync.setPartitionValue(value: bandRef)
            
            realmSync.setCurrentUser(value: id)

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
