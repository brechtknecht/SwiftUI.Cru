//
//  EventListElement.swift
//  Backstage
//
//  Created by Felix Tesche on 02.01.21.
//

import SwiftUI

struct EventListElement: View {
    let viewModel = EventListViewModel()
    
    @State var event: Event
    @State var venue: VenueDB
    
    var body: some View {
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
                    .frame(width: 150, height: 150)
                    .cornerRadius(4)
                    .layoutPriority(1)
                    .clipped()
    
                VStack (alignment: .leading){
                    Text(event.name)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(viewModel.convertDate(date: event.date))
                        .font(.subheadline)
                          
                    Spacer()
                    // IMPORTANT: Test if venue is nil — prevent crashes from empty data
                    if venue != nil {
                        let text = "\(viewModel.venueString(venue: venue))"
                        Text(text)
                            .font(.subheadline)
                            
                            
                    } else {
                        Text("Kein Veranstaltungsort angegeben")
                            .font(.subheadline)
                    }
                }
                .layoutPriority(4)
            }
            
    
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 7, trailing: 16))
    }
}


//struct EventListElement_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListElement()
//    }
//}
