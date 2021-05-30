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
            return try Realm().object(ofType: UserDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension UserStore {
    func create(name: String, bandID: String) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let refDB = UserDB()
            let id = UUID().hashValue
            refDB.id            = id
            refDB._id           = id
            refDB.name          = name
            refDB.bandID        = bandID

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
}
