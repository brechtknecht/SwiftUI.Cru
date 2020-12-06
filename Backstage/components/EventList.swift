//
//  EventList.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct EventList: View {
    var body: some View {
        NavigationLink(destination: EventDetail()) {
            Text("Shiny Shiny Winter Show")
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
