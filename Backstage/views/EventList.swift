//
//  EventList.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct EventList: View {
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var venueStore: VenueStore
    
    var body: some View {
        VStack (alignment: .leading){
            List {
                ForEach(eventStore.events, id: \.id) { event in
                    
                    let venue = venueStore.findByID(id: event.venueID)
                    
                    NavigationLink(destination:
                        EventDetail(
                            eventID: .constant(event.id),
                            eventImage: .constant(event.imageUUID)
                        )
                    ) {
                        VStack (alignment: .leading){
                            let image = Utilities.helpers.loadImageFromUUID(imageUUID: event.imageUUID)
                            Image(uiImage: image)
                                .resizable()
                                .frame(height: 300)
                                .padding(8)
                            
                            Text(event.name)
                                .font(.headline)
                            
                            // IMPORTANT: Test if venue is nil — prevent crashes from empty data
                            if venue != nil {
                                Text("\(venue!.name) " + "\(venue!.location) " + "\(venue!.district), " + "\(venue!.country)")
                            } else {
                                Text("Kein Veranstaltungsort angegeben")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
