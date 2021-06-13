//
//  RealmPersistentInitializer.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift
import Realm

class RealmPersistent {
    static func initializer(alternativePartitionValue: String? = nil) -> Realm {
        realmSync.syncInitializer()
        
        var partitionValue : String
        
        if(alternativePartitionValue == nil) {
            partitionValue = realmSync.partitionValue
        } else {
            partitionValue = alternativePartitionValue!
        }
        
        
        print("Partition Value USED: \(partitionValue)")
        
        
        
        let user = app.currentUser ?? nil
        
        if (user !=  nil) {
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            // Get a sync configuration from the user object.
            do {
                let realm = try Realm(configuration: configuration)
                return realm
            } catch let err {
                fatalError("Failed to open Realm \(err.localizedDescription)")
            }
        } else {
            do {
                let realm = try Realm()
                return realm
            } catch let err {
                fatalError("Failed to open Realm \(err.localizedDescription)")
            }
        }
        
        
    }
}

class RealmSync : ObservableObject {
    @Published var partitionValue = ""
    @Published var userID = 0
    
    init() {
        self.syncInitializer()
    }
    
    func syncInitializer() -> Void {
        
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
                    self.asyncConnection()
                }
            }
        }
    }
    
    
    func asyncConnection() -> Void {
        // The partition determines which subset of data to access.
        let partitionValue = self.partitionValue
        
        let user = app.currentUser!
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        // Open the realm asynchronously to ensure backend data is downloaded first.
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
            case .success(let realm):
                // Realm opened and synced
                print("Realm opened \(realm)")
//                onRealmOpened(realm)
            }
        }
    }
    
        
    func setPartitionValue(value: String) -> Void {
        self.partitionValue = value
        
        // Set partition Value to user defaults
        let defaults = UserDefaults.standard
        
        let currentPartitionValue = defaults.value(forKey: "partitionValue") as? String
        
        if(currentPartitionValue == value) {
            return
        }
        
        defaults.setValue(value, forKey: "partitionValue")
    }
    
    func setCurrentUser(value: Int) -> Void {
        self.userID = value
        
        let defaults = UserDefaults.standard
        
        let currentUserID = defaults.value(forKey: "userID") as? Int
        
        if(currentUserID == value) {
            return
        }
        
        defaults.setValue(value, forKey: "userID")
        
    }
    
    func logout() -> Void {
        self.setPartitionValue(value: "")
    }
    
    public func getPartitionValue() -> String {
        return self.partitionValue
    }
    
    public func getCurrentUser() -> Int {
        return self.userID
    }
}
