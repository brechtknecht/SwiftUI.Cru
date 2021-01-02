//
//  EventList.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI
import RealmSwift

struct EventList: View {
    
    @EnvironmentObject var eventStore: EventStore
    @EnvironmentObject var venueStore: VenueStore
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        HStack {
            Text("Kommende Veranstaltungen")
                .font(.headline)
                .padding(.horizontal, 20)
            Spacer()
        }
        
        VStack {
            ForEach(eventStore.events, id: \.self.id) { event in
                EventListElementPoster(event: event, venue: venueStore.findByID(id: event.venueID))
            }
            .onDelete(perform: onDelete)
            .padding(.vertical, 8)
            .environment(\.editMode, editMode)
        }
        
        
        .padding(8)
        .environment(\.horizontalSizeClass, .regular)
        
    }
    
    
    private func onDelete(with indexSet: IndexSet) {
        eventStore.delete(indexSet: indexSet)
    }
}

class EventListViewModel: ObservableObject {
    
    
    init () {
        
    }
    
    func convertDate (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd. MMM, yyyy"
        
        return formatter.string(from: date)
    }
    
    func venueString (venue: VenueDB?) -> String {
        let venueName = venue!.name
        let venueLocation = venue!.location
        let venueDistict = venue!.district
        let venueCountry = venue!.country
        
        return venueName + ", " + venueLocation + " — " + venueDistict + " " + venueCountry
    }
    
}




struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
