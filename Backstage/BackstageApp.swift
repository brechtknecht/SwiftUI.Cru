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
                .environmentObject(VenueStore(realm: RealmPersistent.initializer()))
                .environmentObject(EventStore(realm: RealmPersistent.initializer()))
                .environmentObject(SettlementStore(realm: RealmPersistent.initializer()))
                .environmentObject(TransportStore(realm: RealmPersistent.initializer()))
                .environmentObject(PersonStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimetableStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimeslotStore(realm: RealmPersistent.initializer()))
                .environmentObject(realmSync)
        }
    }
}


