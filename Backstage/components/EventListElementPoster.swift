
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
                Image("EventFrame")
                    .resizable()
                    .frame(width: 400, height: 550)
                    .aspectRatio(1.12, contentMode: .fill)
                    .cornerRadius(4)
                Image("PaperTexture")
                    .resizable()
                    .frame(width: 400, height: 550)
                    .aspectRatio(1.12, contentMode: .fill)
                    .cornerRadius(4)
                    .blendMode(.multiply)
                
                
                
                
                VStack (alignment: .center){
                    Text(viewModel.convertDate(date: event.date))
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(event.name)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("Konzert".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                }
                .padding(EdgeInsets(top: 32, leading: 32, bottom: 64, trailing: 32))
                
            }.padding(8)
        }
    }
}


//struct EventListElement_Previews: PreviewProvider {
//    static var previews: some View {
//        EventListElement()
//    }
//}
