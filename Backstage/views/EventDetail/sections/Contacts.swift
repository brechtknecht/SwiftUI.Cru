//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI
import RealmSwift

struct Contacts: View {
    
    @Binding var sheetIsActive : ActiveSheet?
    
    @Binding var eventID : Int
    
    @EnvironmentObject var personStore : PersonStore
    @EnvironmentObject var eventStore : EventStore
    
    var body: some View {
        VStack (alignment: .leading){
            
            let personIDs = eventStore.findByID(id: eventID)?.persons ?? RealmSwift.List<Int>()
            
            if(personIDs.count > 0) {
                Text("Kontakte")
                    .foregroundColor(.gray)
                    .font(.body)
                    .textCase(.uppercase)
                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
                VStack {
                    
                    ForEach (personIDs, id: \.self) { personID in
                        
                        let person = personStore.findByID(id: personID)
                        
                        let personName          = person?.name ?? ""
                        let personRole          = person?.role ?? ""
                        
                        Button {
                            print("Test")
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(12)
                                HStack{
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .foregroundColor(Color.white)
                                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                        .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                        .frame(width: 32, height: 32)
                                    Text("\(personName)")
                                        .padding(EdgeInsets(top: 22, leading: 8, bottom: 22, trailing: 8))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(ColorManager.primaryDark)
                                    Spacer()
                                    Text("\(personRole)")
                                        .foregroundColor(Color.white)
                                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                        .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(EdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16))
                        }
                        
                        
                        
                    }
                    
                    
                    Button(action: {
                        self.sheetIsActive = .contact
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(12)
                            HStack{
                                Text("Einen Kontakt hinzufügen")
                                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 22, trailing: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(ColorManager.primaryDark)
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 22, trailing: 16))
                                    .foregroundColor(ColorManager.success)
                            }
    //                        .frame(width: 250, height: 220)
                        }
                        .padding(EdgeInsets(top: 4, leading: 16, bottom: 8, trailing: 16))
                    }
                }
            }

        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
        .background(ColorManager.backgroundForm)
    }
}

//struct Contacts_Previews: PreviewProvider {
//    static var previews: some View {
//        Contacts(sheetIsActive: .constant(.contact))
//    }
//}
