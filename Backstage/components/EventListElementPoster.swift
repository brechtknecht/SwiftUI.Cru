
//
//  EventListElement.swift
//  Backstage
//
//  Created by Felix Tesche on 02.01.21.
//

import SwiftUI

struct EventListElementPoster: View {
    let viewModel = EventListViewModel()
    
    @State var event: Event
    @State var venue: VenueDB
    
    @EnvironmentObject var eventStore: EventStore
    
    var body: some View {
        NavigationLink(destination:
            EventDetail(
                eventID: .constant(event.id)
            )
        ) {
            ZStack {
                let image = Utilities.helpers.loadImageFromUUID(imageUUID: event.imageUUID)
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 400, height: 550)
                    .cornerRadius(4)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                Image("PaperTexture")
                    .resizable()
                    .frame(width: 400, height: 550)
                    .aspectRatio(1.12, contentMode: .fill)
                    .cornerRadius(4)
                    .blendMode(.multiply)
                Image("EventFrame")
                    .resizable()
                    .frame(width: 400, height: 550)
                    .aspectRatio(1.12, contentMode: .fill)
                    .cornerRadius(4)
                
                VStack (alignment: .center){
                    Text(viewModel.convertDate(date: event.date))
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                    Spacer()
                    Text(event.name)
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                    Text("Konzert".uppercased())
                        .font(.headline)
                        .fontWeight(.bold)
                        .tracking(2.54)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 2)
                        .padding(.vertical, 4)
                }
                .padding(EdgeInsets(top: 32, leading: 32, bottom: 64, trailing: 32))
            }
            .padding(8)
        }
        .contextMenu {
            Button("Delete")  {  deleteEventByID(id: event.id) }
        }
    }
    
    
    private func deleteEventByID(id: Int) {
        print("IndexSet : \(id)")
        eventStore.deleteWithID(id: id)
    }
}


//struct EventListElement_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListElement()
//    }
//}
