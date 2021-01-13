//
//  AddSettlement.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI

struct AddSettlement: View {
    @State var settlementName           : String  = ""
    @State var settlementLocation       : String  = ""
    @State var settlementArrivalDate    : Date    = Date()
    @State var settlementDepartureDate  : Date    = Date()
    @State var settlementPrice          : String  = ""
    @State var settlementCurrency       : String  = ""
    
    @State var proposedDate             : Date
    
    @EnvironmentObject var store: SettlementStore
    
    /// Lets the Enviroment pop the Navigation View
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    /// LocationService is used for finding adresses based on the user input
    @ObservedObject var locationService: LocationService
    
    @State var locationHelperActive     : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $settlementName)
                        TextField("Ort",
                                  text: $locationService.queryFragment,
                                  onEditingChanged: { (editingChanged) in
                                    self.locationHelperActive = editingChanged
                                  }
                        )
                        
                        /// The proposed Day is the Date from the event
                        DatePicker(selection: $settlementArrivalDate, in: proposedDate..., displayedComponents: .date) {
                            Text("Datum Ankunft")
                        }
                        
                        /// Adds one Day to the proposed Day
                        DatePicker(selection: $settlementDepartureDate, in: Calendar.current.date(byAdding: .day, value: 1, to: proposedDate)!..., displayedComponents: .date) {
                            Text("Datum Abreise")
                        }
                    }
                    Section (header: Text("Kosten pro Nacht")) {
                        HStack {
                            TextField("Honorar", text: $settlementPrice)
                                .keyboardType(.numberPad)
                            Text("€")
                        }
                    }
                    if(locationHelperActive) {
                        Section(header: Text("Suchergebnisse")) {
                            List {
                                // With Xcode 12, this will not be necessary as it supports switch statements.
                                if locationService.status == .isSearching {
                                    HStack {
                                        Image(systemName: "clock")
                                            .foregroundColor(Color.gray)
                                        Text("Suche nach Ergebnissen")
                                    }
                                }
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
                                        
                                        result = result.replacingOccurrences(of: settlementName, with: "", options: [.caseInsensitive])
                                        result = result.trimmingCharacters(in: .whitespaces)
                                        
                                        self.settlementLocation = result
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
                }
                .navigationTitle("Übernachtungsmöglichkeit hinzufügen").font(.subheadline)
                .navigationBarItems(trailing:  Button(action: {
                    if !settlementName.isEmpty {
                        store.create(
                            name:           settlementName,
                            location:       settlementLocation,
                            arrivalDate:    settlementArrivalDate,
                            departureDate:  settlementDepartureDate,
                            price:          Double(settlementPrice) ?? 0.0,
                            currency:       settlementCurrency
                        )
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



/// Disabled Preview, because it sucks

//struct AddSettlement_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSettlement()
//    }
//}
