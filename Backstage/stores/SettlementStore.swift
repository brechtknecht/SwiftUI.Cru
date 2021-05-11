//
//  SettlementStore.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import SwiftUI

final class SettlementStore: ObservableObject {
    private var results: Results<SettlementDB>
    
    var settlements: [Settlement] {
        results.map(Settlement.init)
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(SettlementDB.self)
    }
    
    func findByID (id: Int) -> SettlementDB! {
        do {
            return try Realm().object(ofType: SettlementDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension SettlementStore {
    func create(id: Int, name: String, location: String, arrivalDate: Date, departureDate: Date, price: Int, currency: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = realmSync.partitionValue
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = SettlementDB()
            refDB.id            = id
            refDB.name          = name
            refDB.location      = location
            refDB.arrivalDate   = arrivalDate
            refDB.departureDate = departureDate
            refDB.price         = price
            refDB.currency      = currency

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
            
            let object = realm.objects(SettlementDB.self).filter("id = %@", id).first
            
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
