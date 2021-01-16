//
//  Settlements.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import SwiftUI
import RealmSwift

struct Transportation: View {
    
    @Binding var sheetIsActive : ActiveSheet?
    
    @Binding var eventID : Int
    
    @EnvironmentObject var transportStore : TransportStore
    @EnvironmentObject var eventStore : EventStore
    
    var body: some View {
        VStack (alignment: .leading){
            
            let transportationIDs = eventStore.findByID(id: eventID)?.transports ?? RealmSwift.List<Int>()
            
            
            Text("Transport")
                .foregroundColor(.gray)
                .font(.body)
                .textCase(.uppercase)
                .padding(EdgeInsets(top: 22, leading: 16, bottom: 0, trailing: 16))
            VStack {
                
                ForEach (transportationIDs, id: \.self) { transportationID in
                    
                    let transport = transportStore.findByID(id: transportationID)
                    
                    let transportName = transport?.name ?? ""
                    let transportationType = transport?.type ?? ""
                    let transpotationPrice = transport?.price ?? 0
                    

                    Button {
                        print("Test")
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(ColorManager.primaryLight)
                                .cornerRadius(12)
                            HStack{
                                Text("\(transportationType)")
                                    .foregroundColor(Color.white)
                                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                                    .background(Rectangle().fill(ColorManager.accent).cornerRadius(4))
                                Text("\(transportName)")
                                    .padding(EdgeInsets(top: 22, leading: 8, bottom: 22, trailing: 8))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(ColorManager.primaryDark)
                                Spacer()
                                Text("\(transpotationPrice)€\(Characters.thinSpace)/\(Characters.thinSpace)Tag")
                                    .padding(EdgeInsets(top: 22, leading: 8, bottom: 22, trailing: 0))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(ColorManager.primaryDark)
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                    }
                }

                
                
                Button(action: {
                    self.sheetIsActive = .transport
                }) {
                    ZStack {
                        Rectangle()
                            .fill(ColorManager.primaryLight)
                            .cornerRadius(12)
                        HStack{
                            Text("Transportoption hinzufügen")
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
        .background(ColorManager.backgroundForm)
    }
}
