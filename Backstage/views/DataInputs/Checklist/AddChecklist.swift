//
//  AddChecklist.swift
//  Backstage
//
//  Created by Felix Tesche on 04.07.21.
//

import SwiftUI

struct AddChecklist: View {
    @State var checklistName           : String = ""
    
    @EnvironmentObject var checklistStore   : ChecklistStore
    @EnvironmentObject var eventStore       : EventStore
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var eventReference       : Int
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Checklist")){
                        TextField("Name", text: $checklistName)
                    }
                }
                .navigationTitle("Checklist erstellen").font(.subheadline)
                .navigationBarItems(trailing:  Button(action: {
                    if !checklistName.isEmpty {
                        
                        let checklistID = UUID().hashValue;
                        
                        checklistStore.create(id: checklistID, name: checklistName)
                        
                        let checklist = checklistStore.findByID(id: checklistID)!
                        
//                        eventStore.addChecklistToEvent(
//                            eventID: eventReference,
//                            person: person
//                        )
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
