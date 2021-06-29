//
//  ContentView.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//  Commit BREAK

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var store: VenueStore
    @EnvironmentObject var userStore : UserStore
    
    var body: some View {
        // Disabled Tabview During Development

        TabView {
            VStack {
                Events()
            }
            .tabItem({
                TabLabel(
                    imageName: "guitars.fill",
                    label: "Events"
                )
            })
            VStack {
                Crew()
            }
            .tabItem({
                TabLabel(
                    imageName: "person.3.fill",
                    label: "Crew"
                )
            })

        }.onAppear{
            self.loadPartitionValueFromUserDefaults()
            
            self.loadCurrentUserFromUserDefaults()
        }
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
        
        print("DefaultUSER \(defaultUser)")
        
        if(defaultUser != 0) {
            realmSync.setCurrentUser(value: defaultUser ?? 0)
            
//            let user = userStore.findByID(id: defaultUser ?? 0)
            
//            realmSync.setCurrentUserData(user: user ?? UserDB())
        }
    }
    
    struct TabLabel: View {
        let imageName: String
        let label: String
        
        var body: some View {
            HStack {
                Image(systemName: imageName)
                Text(label)
            }
        }
    }
    
}
