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
                        ForEach(checklist.items, id: \.self._id) { item in
                            
                            
                            Button {
                                print("Test")
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(ColorManager.responsiveLight)
                                        .cornerRadius(12)
                                    HStack{
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                            .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                            .frame(width: 32, height: 32)
                                        Text("\(item.label)")
                                            .padding(EdgeInsets(top: 22, leading: 8, bottom: 22, trailing: 8))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(ColorManager.primaryDark)
                                        Spacer()
                                        if(item.assignedUser != nil) {
                                            Text("\(item.assignedUser?.name ?? "ERR**NOUSER")")
                                                .foregroundColor(Color.white)
                                                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                                .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                            }
                            
                            
                            
                        }
                        
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
