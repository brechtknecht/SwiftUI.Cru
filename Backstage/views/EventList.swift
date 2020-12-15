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
        VStack (alignment: .leading){
            List {
                Section {
                    ForEach(eventStore.events, id: \.self.id) { event in
                        
                        let venue = venueStore.findByID(id: event.venueID)
                        
                        NavigationLink(destination:
                            EventDetail(
                                eventID: .constant(event.id)
                            )
                        ) {
                            HStack (alignment: .top, spacing: 8) {
                                let image = Utilities.helpers.loadImageFromUUID(imageUUID: event.imageUUID)
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150)
                                    .cornerRadius(4)
                                    .layoutPriority(1)
                    
                                VStack (alignment: .leading){
                                    Text(event.name)
                                        .font(.title3)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                          
                                    Spacer()
                                    // IMPORTANT: Test if venue is nil — prevent crashes from empty data
                                    if venue != nil {
                                        let text = "\(venue!.name) " + "\(venue!.location) " + "\(venue!.district), " + "\(venue!.country)"
                                        Text(text)
                                            .font(.subheadline)
                                            
                                            
                                    } else {
                                        Text("Kein Veranstaltungsort angegeben")
                                            .font(.subheadline)
                                    }
                                }
                                .layoutPriority(4)
                            }
                            .frame(height: 125)
                    
                        }
                    }.onDelete(perform: onDelete)
                }
                .padding(.vertical, 8)
                
            }
            .environment(\.editMode, editMode)
        }
//        .listStyle(InsetGroupedListStyle())
        .listStyle(InsetListStyle())
        .padding(0)
        .environment(\.horizontalSizeClass, .regular)
        
    }
    
    
    private func onDelete(with indexSet: IndexSet) {
        eventStore.delete(indexSet: indexSet)
    }
}


struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
