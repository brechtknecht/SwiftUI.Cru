//
//  Events.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI
import RealmSwift

struct Events: View {
    @State var showingCreateNewEvent = false
    
    // Irgendwie muss das hier manuell gebaut werden
    // https://stackoverflow.com/questions/58084501/swiftui-editmode-and-presentationmode-environment
    
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var venueStore: VenueStore
    @EnvironmentObject var userStore: UserStore
    
   
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                EventList()
            }
            .environment(\.editMode, editMode)
            .navigationBarTitle("Veranstaltungen")
            .navigationBarItems(
                leading: CEditButton()
                    .disabled(eventStore.events.count == 0)
                    .environment(\.editMode, editMode)
                ,
                trailing: HStack {
                    Button(action: {
                        self.showingCreateNewEvent.toggle()
                    }) {
                        Text("Event hinzufügen")
                    }.fullScreenCover(isPresented: $showingCreateNewEvent) {
                        CreateNewEvent()
                    }
            })
        }
    }
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
