//
//  VenueListItem.swift
//  Backstage
//
//  Created by Felix Tesche on 10.05.21.
//

import SwiftUI
import RealmSwift

struct VenueListItem: View {
    @State var venue : Venue
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(venue.name)")
                .foregroundColor(ColorManager.primaryDark)
            
            Text("\(venue.location) \(venue.street) \(venue.country)")
                .foregroundColor(ColorManager.primaryDark)
                .font(.body)
        }.padding(.vertical, 8)
    }
}
