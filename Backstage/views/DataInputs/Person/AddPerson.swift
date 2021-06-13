//
//  AddPerson.swift
//  Backstage
//
//  Created by Felix Tesche on 16.01.21.
//

import SwiftUI

struct AddPerson: View {
    @State var personName           : String = ""
    @State var personRole           : String = ""
    @State var personPhoneNumber    : String = ""
    
    @EnvironmentObject var personStore : PersonStore
    @EnvironmentObject var eventStore : EventStore
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var eventReference       : Int
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Person Information")){
                        TextField("Name", text: $personName)
                        
                        TextField("Role", text: $personRole)
                        
                        TextField("PhoneNumber", text: $personPhoneNumber)
                    }
                }
                .navigationTitle("Beteiligten hinzufügen").font(.subheadline)
                .navigationBarItems(trailing:  Button(action: {
                    if !personName.isEmpty {
                        
                        let personUUID = UUID().hashValue;
                        
                        personStore.create(
                            id                  : personUUID,
                            name                : personName,
                            role                : personRole,
                            phoneNumber         : personPhoneNumber
                        )
                        
                        let person = personStore.findByID(id: personUUID)!
                        
                        eventStore.addPersonToList(
                            eventID: eventReference,
                            person: person
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

//struct AddPerson_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPerson()
//    }
//}
