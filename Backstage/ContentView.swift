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
            self.loadCurrentUserFromUserDefaults()
        }
    }
    
    func loadCurrentUserFromUserDefaults () -> Void {
        let defaults = UserDefaults.standard
        
        guard let defaultUser = defaults.value(forKey: "userID") else {
            print("No User-Data was found")
            return
        }
        
        if(defaultUser as! Int == 0) {
            print("default User Undefined — returning and waiting for user to register")
            return
        }
        
        realmSync.setCurrentUser(value: defaultUser as! Int)
            
        let user = userStore.findByID(id: defaultUser as! Int)
            
        realmSync.setCurrentUserData(user: user ?? UserDB())
        
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
