//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI

struct Settlements: View {
    
    @Binding var sheetIsActive: ActiveSheet?
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Übernachtungemöglichkeit")
                .foregroundColor(.gray)
                .font(.body)
                .textCase(.uppercase)
                .padding(EdgeInsets(top: 22, leading: 16, bottom: 4, trailing: 16))
            ScrollView(.horizontal, showsIndicators: false){
                Button(action: {
                    self.sheetIsActive = .settlement
                }) {
                    ZStack {
                        Rectangle()
                            .fill(ColorManager.primaryLight)
                            .cornerRadius(12)
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(EdgeInsets(top: 64, leading: 16, bottom: 8, trailing: 16))
                                .foregroundColor(ColorManager.success)
                            Text("Übernachtungsmöglichkeit hinzufügen")
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(ColorManager.primaryDark)
                            
                        }
                        .frame(width: 250, height: 220)
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
            }
        }
        .background(ColorManager.backgroundForm)
    }
}
