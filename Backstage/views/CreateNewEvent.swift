//
//  CreateNewEvent.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct CreateNewEvent: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var eventName = ""
    @State var eventDate = Date()
    @State var eventType = 0
    
    
    var strengths = ["Mild", "Medium", "Mature"]
    
    @State private var selectedStrength = 0
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    Section(header: Text("Allgemeine Informationen")) {
                        TextField("Name", text: $eventName)
                        DatePicker(selection: $eventDate, in: ...Date(), displayedComponents: .date) {
                            Text("Datum")
                        }
                        Picker(selection: $eventType, label: Text("What is your favorite color?")) {
                            Text("Clubauftritt").tag(0)
                            Text("Festivalauftritt").tag(1)
                            Text("Tourauftritt").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Veranstaltungsort")) {
                        Section {
                            Picker(selection: $selectedStrength, label: Text("Venue")) {
                                ForEach(0 ..< strengths.count) {
                                    Text(self.strengths[$0])
                                    
                                }
                            }
                        }
                        
                    }
                }
                Section {
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        HStack {
                            Text("Event Abschließen")
                                .fontWeight(.semibold)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(14)
                        .foregroundColor(.white)
                        .background(ColorManager.primaryDark)
                        .cornerRadius(8)
                    }
                }
                .padding(8)
            }
            
            
            .navigationBarTitle("Event erstellen")
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
