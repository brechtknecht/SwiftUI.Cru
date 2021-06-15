//
//  BackstageApp.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI
import UIKit
import RealmSwift

let app = App(id: "backstage-ghsov") // Global App Object for SYNCING data with and to LOGIN against
let realmSync = RealmSync()


@main
struct BackstageApp: SwiftUI.App {
    @StateObject var realmSyncUI = realmSync
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BandStore(realm: RealmPersistent.initializer(alternativePartitionValue: "all-the-users")))
                .environmentObject(UserStore(realm: RealmPersistent.initializer(alternativePartitionValue: "all-the-users")))
                .environmentObject(VenueStore(realm: RealmPersistent.initializer()))
                .environmentObject(EventStore(realm: RealmPersistent.initializer()))
                .environmentObject(SettlementStore(realm: RealmPersistent.initializer()))
                .environmentObject(TransportStore(realm: RealmPersistent.initializer()))
                .environmentObject(PersonStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimetableStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimeslotStore(realm: RealmPersistent.initializer()))
                
                .environmentObject(realmSync)
                .environment(\.realmConfiguration, self.initializeConfiguration())
                .onAppear{
                    self.loadPartitionValueFromUserDefaults()
                    
                    self.loadCurrentUserFromUserDefaults()
                }
        }
    }
    
    func initializeConfiguration () -> Realm.Configuration {
        if(app.currentUser != nil) {
            return app.currentUser!.configuration(partitionValue: realmSync.partitionValue)
        }
        return Realm.Configuration.defaultConfiguration
    }
    
    func loadPartitionValueFromUserDefaults () -> Void {
        let defaults = UserDefaults.standard
        
        let defaultPartitionValue = defaults.value(forKey: "partitionValue") as? String
        
        if(defaultPartitionValue != "") {
            realmSync.setPartitionValue(value: defaultPartitionValue ?? "")
        }
    }
    
    func loadCurrentUserFromUserDefaults () -> Void {
        let defaults = UserDefaults.standard
        
        let defaultUser = defaults.value(forKey: "userID") as? Int
        
        if(defaultUser != 0) {
            realmSync.setCurrentUser(value: defaultUser ?? 0)
        }
    }
}


