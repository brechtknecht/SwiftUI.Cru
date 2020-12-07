//
//  EventListItem.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import SwiftUI

struct EventListItem: View {
    @Binding var eventName: String
    
    var body: some View {
        Section {
            VStack (alignment: .leading){
                Text("\(eventName)")
            }
        }
    }
}

struct EventListItem_Previews: PreviewProvider {
    static var previews: some View {
        EventListItem(eventName: .constant("Eventname"))
    }
}
