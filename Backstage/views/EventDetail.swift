//
//  EventDetail.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct EventDetail: View {
    @EnvironmentObject var eventStore: EventStore

    @Binding var eventID: Int
    @Binding var eventImage: String
    
    var body: some View {
        let image = Utilities.helpers.loadImageFromUUID(imageUUID: eventImage)
        
        ScrollView {
            GeometryReader { geometry in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                    .clipped()
                    .offset(y: -geometry.frame(in: .global).minY)
            }
            .frame(height: 400)
        }
        .edgesIgnoringSafeArea(.top)
        VStack {
            Text("\(eventID)")
            Text("\(eventStore.findByID(id: eventID).name)")
        }
        
        
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(
            eventID: .constant(3503817091713033700),
            eventImage: .constant("Empty Image")
        )
    }
}
