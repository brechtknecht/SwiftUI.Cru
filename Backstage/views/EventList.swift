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
    
    @ObservedResults(EventDB.self) var events
    @Environment(\.realm) var eventRealm
    
    @Environment(\.editMode) var editMode
    
    static let monthDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    static let yearDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text("Alle kommenden Verabredungen")
                    .font(.headline)
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 22, bottom: 4, trailing: 22))
            
            // Creates a Dictionary with the events saved for each month into a key, value pair
            
            if (eventStore.events.count > 1) {
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
                
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    
                    // Iterates over the Array of Events and Enumerates
                    // the Current month as a header for sorting
                    ForEach(Array(sortedEvents.enumerated()), id: \.offset) { index, events in
                        // Displays the current Month
                        Section(
                            header:
                                VStack {
                                    HStack (alignment: .firstTextBaseline){
                                        Text("\(events.key, formatter: Self.monthDateFormat)")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
                                        Text("\(events.key, formatter: Self.yearDateFormat)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.gray)
                                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 16))
                                        Spacer()
                                    }
                                    .background(
                                        Rectangle()
                                            .fill(ColorManager.responsiveWhite.opacity(0.8))
                                            .frame(height: 60)
                                    )
                                }
                            )
                        {
                        // Displays the actual Event
                            VStack (spacing: 0){
                                ForEach(events.value, id: \.id) { event in
                                    EventListElement(event: event, venue: venueStore.findByID(id: event.venueID) ?? VenueDB())
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: onDelete)
                    .environment(\.editMode, editMode)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                }
            } else {
                
                // INITIAL STATE and fallback if there is only one Event and it could lead to a crash
                VStack(spacing: 0){
                    ForEach(eventStore.events, id: \.self.id) { event in
                        EventListElement(event: event, venue: venueStore.findByID(id: event.venueID) ?? VenueDB())
                    }
                    .onDelete(perform: onDelete)
                    .environment(\.editMode, editMode)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                }
            }
        }
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
