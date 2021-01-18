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
    
    let CARD_WIDTH : CGFloat = 180
    let CARD_HEIGHT : CGFloat = 150
    
    @Environment(\.editMode) var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    var body: some View {
        NavigationLink(destination:
            EventDetail(
                eventID: .constant(event.id)
            )
        ) {
            HStack {
                ZStack {
                    let image = Utilities.helpers.loadImageFromUUID(imageUUID: event.imageUUID, compression: 0.5)
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .cornerRadius(4)
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .opacity(isEditing ? 0.4 : 1)
                    Image("PaperTexture")
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .aspectRatio(1.12, contentMode: .fill)
                        .cornerRadius(4)
                        .blendMode(.multiply)
                        .opacity(isEditing ? 0.4 : 1)
                    Image("EventFrame")
                        .resizable()
                        .frame(width: CARD_WIDTH, height: CARD_HEIGHT)
                        .aspectRatio(1.12, contentMode: .fill)
                        .cornerRadius(4)
                        .opacity(isEditing ? 0.15 : 1)
                }
                
                
                VStack (alignment: .leading){
                    Text(viewModel.convertDate(date: event.date))
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(event.name)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Text(event.type.uppercased())
                        .font(.headline)
                        .fontWeight(.bold)
                        .tracking(2.54)
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                } .layoutPriority(4)
    
//                VStack (alignment: .leading){
//                    Text(event.name)
//                        .font(.title3)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    Text(viewModel.convertDate(date: event.date))
//                        .font(.subheadline)
//
//                    Spacer()
//                    // IMPORTANT: Test if venue is nil — prevent crashes from empty data
//                    if venue != nil {
//                        let text = "\(viewModel.venueString(venue: venue))"
//                        Text(text)
//                            .font(.subheadline)
//
//
//                    } else {
//                        Text("Kein Veranstaltungsort angegeben")
//                            .font(.subheadline)
//                    }
//                }
//                .layoutPriority(4)
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
