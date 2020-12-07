//
//  AddVenueForm.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import SwiftUI

struct AddVenueForm: View {
    @State var venueName = ""
    @State var venueLocation = ""
    @State var venueDistrict = ""
    @State var venueCountry = ""
    
    
    @EnvironmentObject var store: VenueStore
    // Lets the Enviroment pop the Navigation View
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body : some View {
        NavigationView {
            Section {
                Form {
                    TextField("Name",       text: $venueName)
                    TextField("Ort",        text: $venueLocation)
                    TextField("Bundesland", text: $venueDistrict)
                    TextField("Land",       text: $venueCountry)
                }
            }
            .navigationTitle("Venue hinzufügen").font(.subheadline)
            .navigationBarItems(trailing:  Button(action: {
                if !venueName.isEmpty {
                    store.create(name: venueName, location: venueLocation, district: venueDistrict, country: venueCountry)
                }
                
                // Pop Navigation State
                self.mode.wrappedValue.dismiss()
            }) {
                Text("Fertig")
            })
        }
    }
}

struct AddVenueForm_Previews: PreviewProvider {
    static var previews: some View {
        AddVenueForm()
    }
}
