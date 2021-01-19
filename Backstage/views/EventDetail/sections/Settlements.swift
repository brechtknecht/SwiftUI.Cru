//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI
import RealmSwift

struct Settlements: View {
    static let settlementDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. MMM"
        return formatter
    }()
    
    @Binding var sheetIsActive: ActiveSheet?
    @Binding var eventID : Int
    
    @EnvironmentObject var settlementStore: SettlementStore
    @EnvironmentObject var eventStore : EventStore
    
    var body: some View {
        VStack (alignment: .leading){
            
            let settlementIDs = eventStore.findByID(id: eventID)?.settlements ?? RealmSwift.List<Int>()
            
            if(settlementIDs.count > 0) {
                Text("Übernachtungemöglichkeit")
                    .foregroundColor(.gray)
                    .font(.body)
                    .textCase(.uppercase)
                    .padding(EdgeInsets(top: 22, leading: 16, bottom: 4, trailing: 16))
                ScrollView(.horizontal, showsIndicators: false){
                    
                    
                    
    //                let viewModel = SettlementViewModel(eventID: eventID, eventStore: eventStore)
                
                    HStack {
                        ForEach(settlementIDs, id: \.self) { settlementID in
                            let settlement = settlementStore.findByID(id: settlementID)
                            
                            /// Unwrapping all the data needed
                            let settlementLocation      = settlement?.location      ?? ""
                            let settlementName          = settlement?.name          ?? ""
                            let settlementArrivalDate   = settlement?.arrivalDate   ?? Date()
                            let settlementDepartureDate = settlement?.departureDate ?? Date()
                            let settlementPrice         = settlement?.price         ?? 0
                            
                            Button(action: {
                                self.sheetIsActive = .settlement
                            }) {
                                ZStack {
                                    SettlementMap(adress: settlementLocation)
                                    Rectangle()
                                        .fill(ColorManager.primaryLight.opacity(0.6))
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                        )
                                    VStack(){
                                        Text("\(settlementName)")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(ColorManager.primaryDark)
                                            .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
                                            .frame(width: 250, alignment: .leading)
                                        Spacer()
                                        Text(
                                            "\(settlementArrivalDate, formatter: Self.settlementDateFormat) — \(settlementDepartureDate, formatter: Self.settlementDateFormat)"
                                        )
                                            .font(.headline)
                                            .foregroundColor(ColorManager.primaryDark)
                                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                                            .frame(width: 250, alignment: .leading)
                                        
                                        Text("\(settlementPrice)\(Characters.hairSpace)€\(Characters.thinSpace)/\(Characters.thinSpace)Person")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(ColorManager.primaryDark)
                                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8))
                                            .frame(width: 250, alignment: .leading)
                                    }
                                    .frame(width: 250, height: 220)
                                }
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                            }
                        }
                        
                        // - Create Button
                        
                        Button(action: {
                            self.sheetIsActive = .settlement
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
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
                                .frame(width: 270, height: 250)
                            }
                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                        }
                    }
                    .padding(.leading, 16)
                }
            }
        }
        .background(ColorManager.backgroundForm)
    }
}


class SettlementViewModel: ObservableObject {
    var eventStore: EventStore
    private var settlementIDs: RealmSwift.List<Int>
    
    init(eventID: Int, eventStore: EventStore) {
        self.eventStore = eventStore
        self.settlementIDs = eventStore.findByID(id: eventID)?.settlements ?? RealmSwift.List<Int>()
    }
}
