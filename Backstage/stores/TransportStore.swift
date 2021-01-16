//
//  TransportStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

final class TransportStore: ObservableObject {
    private var results: Results<TransportDB>
    
    var transports: [Transport] {
        results.map(Transport.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(TransportDB.self)
    }
    
    func findByID (id: Int) -> TransportDB! {
        do {
            return try Realm().object(ofType: TransportDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension TransportStore {
    func create(id: Int, name: String, tag: String, isRented: Bool, price: Int) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let refDB = TransportDB()
            refDB.id            = id
            refDB.name          = name
            refDB.tag           = tag
            refDB.isRented      = isRented
            refDB.price         = price

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
            
            let object = realm.objects(TransportDB.self).filter("id = %@", id).first
            
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
