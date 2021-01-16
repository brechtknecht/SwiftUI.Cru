//
//  AddTransport.swift
//  Backstage
//
//  Created by Felix Tesche on 16.01.21.
//

import SwiftUI

enum CarType: String, Equatable, CaseIterable {
    case car            = "Auto"
    case transporter    = "Transporter"
    case bus            = "Bus"
    case nightliner     = "Nightliner"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    
    var selected: String {
        switch self {
            case .car           : return "Auto"
            case .transporter   : return "Transporter"
            case .bus           : return "Bus"
            case .nightliner    : return "Nightliner"
        }
    }
}

struct AddTransport: View {
    @State var transportName        : String    = ""
    @State var transportTag         : String    = ""
    @State var transportSeats       : Int       = 0
    @State var transportType        : CarType   = .car
    @State var transportIsRented    : Bool      = false
    @State var transportPrice       : String    = ""
    
    @EnvironmentObject var transportStore   : TransportStore
    @EnvironmentObject var eventStore       : EventStore
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var eventReference           : Int
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Vehicle Information")){
                        TextField("Name", text: $transportName)
                        Picker(selection: $transportType, label: Text("")) {
                            ForEach(CarType.allCases, id: \.self) { value in
                                Text(value.localizedName)
                                    .tag(value)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical, 8)
                        
                        Stepper("Seats: \(transportSeats)", value: $transportSeats)
                    }
                    Section (header: Text("Rental and costs")) {
                        Toggle(isOn: $transportIsRented) {
                            Text("Is Rented")
                        }
                        TextField("Price per Day", text: $transportPrice)
                            .keyboardType(.numberPad)
                        Text("€")
                    }
                }
                
                .navigationTitle("Transport hinzufügen").font(.subheadline)
                .navigationBarItems(trailing:  Button(action: {
                    if !transportName.isEmpty {
                        
                        let transportUUID = UUID().hashValue;
                        
                        transportStore.create(
                            id                  : transportUUID,
                            name                : transportName,
                            tag                 : transportTag,
                            seats               : transportSeats,
                            type                : transportType.rawValue,
                            isRented            : transportIsRented,
                            price               : Int(transportPrice) ?? 0
                        )
                        
                        eventStore.addTransportToList(
                            eventID: eventReference,
                            transportID: transportUUID
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

//struct AddTransport_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTransport()
//    }
//}
