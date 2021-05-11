//
//  ContentView.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var store: VenueStore
    
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

        }
        .environment(\.realmConfiguration,
                      app.currentUser!.configuration(partitionValue: realmSync.partitionValue)
         )
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
