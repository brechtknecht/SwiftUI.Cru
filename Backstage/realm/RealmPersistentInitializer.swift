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
                    asyncConnection()
                }
            }
        }
    }
    
    
    static func asyncConnection() -> Void {
        // The partition determines which subset of data to access.
        let partitionValue = "band123"
        
        let user = app.currentUser!
        // Get a sync configuration from the user object.
        var configuration = user.configuration(partitionValue: partitionValue)
        // Open the realm asynchronously to ensure backend data is downloaded first.
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
            case .success(let realm):
                // Realm opened
                print("Realm opened")
//                onRealmOpened(realm)
            }
        }

    }
}
