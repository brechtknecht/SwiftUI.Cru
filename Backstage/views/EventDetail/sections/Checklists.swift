//
//  Checklists.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI
import RealmSwift

struct Checklists: View {
    @Binding var eventID : Int
    
    @EnvironmentObject var checklistStore   : ChecklistStore
    @EnvironmentObject var eventStore       : EventStore
    
    @State var checklistItemInput : String = ""
    @State var isEditing : Bool = false
    
    var body: some View {
        VStack (alignment: .leading){
            
            let checklists = eventStore.findByID(id: eventID)?.checklists ?? RealmSwift.List<ChecklistDB>()
            
            if(checklists.count > 0) {
                Text("Checklisten")
                    .foregroundColor(.gray)
                    .font(.body)
                    .textCase(.uppercase)
                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
                VStack {
                    
                    ForEach (checklists, id: \.self) { checklist in
                        ForEach(checklist.items, id: \.self) { item in
                            Text(item.label.description.capitalized)
                        }
                        
                        if(isEditing) {
                            TextField("Eintrag",
                                 text: $checklistItemInput,
                                 onCommit: {
                                    commitChecklistItem(checklistID: checklist.id)
                                 }
                            )
                        }
                        Button("Add new Item") {
                            isEditing = true
                        }
                    }
                }
            }

        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
        .background(ColorManager.backgroundForm)
    }
    
    func commitChecklistItem (checklistID : Int) {
        isEditing = false
        
        guard let checklist = checklistStore.findByID(id: checklistID) else {
            return
        }
        
        checklistStore.addChecklistItem(checklist: checklist, checklistInput: checklistItemInput)
    }
}
