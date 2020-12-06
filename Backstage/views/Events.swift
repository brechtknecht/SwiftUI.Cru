//
//  Events.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Events: View {
    @State var showingCreateNewEvent = false
    
    var body: some View {
        NavigationView {
            EventList()
            .navigationBarTitle("Veranstaltungen")
            .navigationBarItems(trailing: HStack {
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
