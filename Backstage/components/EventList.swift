//
//  EventList.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct EventList: View {
    
    @EnvironmentObject var eventStore: EventStore
    
    var body: some View {
        ForEach(eventStore.events, id: \.id) { event in
            NavigationLink(destination:
                EventDetail(eventID: .constant(event.id))
            ) {
                Text("\(event.name)")
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
