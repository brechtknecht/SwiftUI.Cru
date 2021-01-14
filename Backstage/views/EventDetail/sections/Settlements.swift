//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI

struct Settlements: View {
    static let settlementDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. MMM"
        return formatter
    }()
    
    @Binding var sheetIsActive: ActiveSheet?
    
    @EnvironmentObject var settlementStore: SettlementStore
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Übernachtungemöglichkeit")
                .foregroundColor(.gray)
                .font(.body)
                .textCase(.uppercase)
                .padding(EdgeInsets(top: 22, leading: 16, bottom: 4, trailing: 16))
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(settlementStore.settlements, id: \.self.id) { settlement in
                        Button(action: {
                            self.sheetIsActive = .settlement
                        }) {
                            ZStack{
                                SettlementMap(adress: settlement.location)
                                Rectangle()
                                    .fill(ColorManager.primaryLight.opacity(0.4))
                                    .cornerRadius(12)
                                VStack(alignment: .leading){
                                    Text("\(settlement.name)")
                                        .font(.headline)
                                        .foregroundColor(ColorManager.primaryDark)
                                    
                                    Text(
                                        "\(settlement.arrivalDate, formatter: Self.settlementDateFormat) — \(settlement.departureDate, formatter: Self.settlementDateFormat)"
                                    )
                                        .foregroundColor(ColorManager.primaryDark)
                                    
                                    Text("\(settlement.price) € / Person")
                                        .foregroundColor(ColorManager.primaryDark)
                                }
                                .frame(width: 250, height: 220)
                            }
                            .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                        }
                    }
                    
                    
                    
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
                            .frame(width: 300, height: 260)
                        }
                        .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
                    }
                }
                .padding(.leading, 16)
            }
        }
        .background(ColorManager.backgroundForm)
    }
}
