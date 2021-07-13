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
        
        let checklists = eventStore.findByID(id: eventID)?.checklists ?? RealmSwift.List<ChecklistDB>()
        
        if(checklists.count > 0) {
            Text("Checklisten")
                .foregroundColor(.gray)
                .font(.body)
                .textCase(.uppercase)
                .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
            VStack {
                
                ForEach (checklists, id: \.self) { checklist in
                    LazyVStack {
                        ForEach(checklist.items, id: \.self._id) { item in
                            ZStack {
                                if(item.isDone) {
                                    Rectangle().fill(ColorManager.responsiveLight).cornerRadius(12)
                                        .padding(.horizontal, 12)
                                }
                                Button(action: {
                                    updateAndCheckListElement(checklistID: checklist.id, checklistItemID: item._id)
                                }) {
                                    HStack (alignment: .center){
                                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                            .resizable()
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                            .background(
                                                Rectangle().fill(ColorManager.accent).cornerRadius(4)
                                            )
                                            .frame(width: 32, height: 32)
                                        Text("\(item.label)")
                                            .padding(EdgeInsets(top: 16, leading: 2, bottom: 16, trailing: 8))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(ColorManager.primaryDark)
                                        Spacer()
                                        if(item.assignedUser != nil) {
                                            Text("\(item.assignedUser?.name ?? "ERR**NOUSER")")
                                                .foregroundColor(Color.white)
                                                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                                .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                        }
                                    }.padding(.horizontal, 24)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    
                    if(isEditing) {
                        
                        TextField("Eintrag",
                                  text: $checklistItemInput,
                                  onCommit: {
                                    commitChecklistItem(checklistID: checklist.id)
                                  }
                        )
                    } else {
                        Button(action: {
                            isEditing = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Neuer Eintrag")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func commitChecklistItem (checklistID : Int) {
        isEditing = false
        
        guard let checklist = checklistStore.findByID(id: checklistID) else {
            return
        }
        
        let id = UUID().hashValue
        
        checklistStore.addChecklistItem(checklist: checklist, checklistInput: checklistItemInput, id: id)
    }
    
    func updateAndCheckListElement (checklistID: Int, checklistItemID: Int) {
        guard let checklist = checklistStore.findByID(id: checklistID) else {
            return
        }
        
        let user = realmSync.user
        
        checklistStore.updateChecklistItem(checklist: checklist, checklistItemID: checklistItemID, currentUser: user)
    }
}
