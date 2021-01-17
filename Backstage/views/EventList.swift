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
    
    static let monthDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    
    var body: some View {
        HStack {
            Text("Deine nächsten Events")
                .font(.headline)
                .padding(.horizontal, 20)
            Spacer()
        }
        
        // Creates a Dictionary with the events saved for each month into a key, value pair
        let empty: [Date: [Event]] = [:]
        let groupedByDate = eventStore.separatedEvents.reduce(into: empty) { acc, cur in
            let components = Calendar.current.dateComponents([.year, .month], from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        
        // Sorts the Elements based on the Date
        let sortedEvents = groupedByDate.sorted {
            $0.key < $1.key
        }
        
        ForEach(Array(sortedEvents.enumerated()), id: \.offset) { index, events in
            // Displays the current Month
            
            HStack {
                Text("\(events.key, formatter: Self.monthDateFormat)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: -16, trailing: 0))
            
            
            ForEach(events.value, id: \.id) { event in
                EventListElementPoster(event: event, venue: venueStore.findByID(id: event.venueID))
            }
        }
        .onDelete(perform: onDelete)
        .environment(\.editMode, editMode)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
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
        let venueDistict = venue!.street
        let venueCountry = venue!.country
        
        return venueName + ", " + venueLocation + " — " + venueDistict + " " + venueCountry
    }
    
}




struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
