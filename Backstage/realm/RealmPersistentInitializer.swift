//
//  RealmPersistentInitializer.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

class RealmPersistent {
    static func initializer() -> Realm {
        do {
            let realm = try Realm()
            
            RealmSync.syncInitializer()
            
            return realm
        } catch let err {   
            fatalError("Failed to open Realm \(err.localizedDescription)")
        }
    }
}

let app = App(id: "backstage-ghsov") // Global App Object for SYNCING data with and to LOGIN against

class RealmSync {
    static func syncInitializer() -> Void {
        
        // Log in anonymously.
        
        app.login(credentials: Credentials.anonymous) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                case .success(let user):
                    print("Login as \(user) succeeded!")
                    // Continue below
                }
            }
        }
    }
}
