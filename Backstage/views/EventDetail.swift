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
        Text("\(eventID)")
        Text("\(eventStore.findByID(id: eventID).name)")
        
        let documentsPath = Utilities.helpers.getDocumentsDirectory()
        let imageURL = URL(fileURLWithPath: documentsPath.absoluteString).appendingPathComponent(eventImage)
        let image    = UIImage(contentsOfFile: imageURL.path)
        
        Image(uiImage: image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height:100)
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
