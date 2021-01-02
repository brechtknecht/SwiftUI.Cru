//
//  ContentView.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: VenueStore
    
    var body: some View {
        
        
        // Disabled Tabview During Development
        
        Events()
//        TabView {
//            VStack {
//                Overview()
//            }
//            .tabItem({
//                TabLabel(
//                    imageName: "music.note.house.fill",
//                    label: "Übersicht"
//                )
//            })
//            VStack {
//                Events()
//            }
//            .tabItem({
//                TabLabel(
//                    imageName: "guitars.fill",
//                    label: "Events"
//                )
//            })
//            VStack {
//                Crew()
//            }
//            .tabItem({
//                TabLabel(
//                    imageName: "person.3.fill",
//                    label: "Crew"
//                )
//            })
//
//        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
