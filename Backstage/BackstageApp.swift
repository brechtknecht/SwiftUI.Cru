//
//  BackstageApp.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI
import UIKit

@main
struct BackstageApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "band_id=123"))
                .environmentObject(VenueStore(realm: RealmPersistent.initializer()))
                .environmentObject(EventStore(realm: RealmPersistent.initializer()))
                .environmentObject(SettlementStore(realm: RealmPersistent.initializer()))
                .environmentObject(TransportStore(realm: RealmPersistent.initializer()))
                .environmentObject(PersonStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimetableStore(realm: RealmPersistent.initializer()))
                .environmentObject(TimeslotStore(realm: RealmPersistent.initializer()))
        }
    }
}


