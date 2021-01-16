//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI

struct Contacts: View {
    
    @Binding var sheetIsActive : ActiveSheet?
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Kontakte")
                .foregroundColor(.gray)
                .font(.body)
                .textCase(.uppercase)
                .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
            VStack {
                Button(action: {
                    self.sheetIsActive = .contact
                }) {
                    ZStack {
                        Rectangle()
                            .fill(ColorManager.primaryLight)
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
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
            

        }
        .background(ColorManager.backgroundForm)
    }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts(sheetIsActive: .constant(.contact))
    }
}
