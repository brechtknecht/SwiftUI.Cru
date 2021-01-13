//
//  AddVenueForm.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import SwiftUI
import CoreLocation

struct AddVenueForm: View {
    @State var venueName = ""
    @State var venueLocation = ""
    @State var venueStreet = ""
    @State var venueCountry = ""
    
    
    @EnvironmentObject var store: VenueStore
    // Lets the Enviroment pop the Navigation View
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var locationService: LocationService
    
    var body : some View {
        NavigationView {
            VStack {
                Form {
                Section {
                        TextField("Name", text: $venueName)
                        TextField("Ort",  text: $locationService.queryFragment)
                        if locationService.status == .isSearching {
                            Image(systemName: "clock")
                                .foregroundColor(Color.gray)
                        }
//                        TextField("Adresse",    text: $venueStreet)
//                        TextField("Land",       text: $venueCountry)
                    }
                    Section(header: Text("Results")) {
                        List {
                            // With Xcode 12, this will not be necessary as it supports switch statements.
                            Group { () -> AnyView in
                                switch locationService.status {
                                case .noResults: return AnyView(Text("No Results"))
                                case .error(let description): return AnyView(Text("Error: \(description)"))
                                default: return AnyView(EmptyView())
                                }
                            }.foregroundColor(Color.gray)

                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                // This simply lists the results, use a button in case you'd like to perform an action
                                // or use a NavigationLink to move to the next view upon selection.
                                Button(action: {
                                    var result = "\(completionResult.title) \(completionResult.subtitle)"
            
                                    result = result.replacingOccurrences(of: venueName, with: "", options: [.caseInsensitive])
                                    
                                    self.venueLocation = result
                                    locationService.queryFragment = result
                                }) {
                                    VStack (alignment: .leading){
                                        Text(completionResult.title)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                        Text(completionResult.subtitle)
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Venue hinzufügen").font(.subheadline)
                .navigationBarItems(trailing:  Button(action: {
                    if !venueName.isEmpty {
                        store.create(name: venueName, location: venueLocation, street: venueStreet, country: venueCountry)
                    }
                    
                    // Pop Navigation State
                    self.mode.wrappedValue.dismiss()
                }) {
                    Text("Fertig")
                })
                
            }
            
        }
    }
}

class AddVenueFormViewModel: ObservableObject {
    @Published var name = ""
    @Published var location = ""
    @Published var street = ""
    @Published var country = ""
    
    var venueItemId: Int?
    
    var updating: Bool {
        venueItemId != nil
    }
    
    init() {}
    
    init(_ venue: Venue) {
        name = venue.name
        location = venue.location
        street = venue.street
        country = venue.country
    }
}

//struct AddVenueForm_Previews: PreviewProvider {
//    static var previews: some View {
//        AddVenueForm()
//    }
//}
