//
//  CreateNewEvent.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct CreateNewEvent: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Text("Neues Event Erstellen")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Fertig")
                }
            })
        }
    }
}

struct CreateNewEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewEvent()
    }
}
