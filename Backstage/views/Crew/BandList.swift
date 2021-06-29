//
//  BandList.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct BandList: View {
    private var user : UserDB = realmSync.user
    
    var body: some View {
        
        VStack {
            ForEach(user.bands, id: \.self) { band in
                VStack (alignment: .leading) {
                    HStack {
                        Text("\(band.name)").font(.title).fontWeight(.semibold)
                        Spacer()
                        BandIcon()
                    }
                    
                    
                    HStack {
                        Spacer()

                        VStack (alignment: .center){
                            QRCodeView(url: band.bandRef)
                            
                            Button(action: {
                                UIPasteboard.general.string = realmSync.partitionValue
                            }) {
                                VStack {
                                    HStack {
                                        Text("Copy to clipboard")
                                        Image(systemName: "doc.on.doc")
                                    }
                                }
                            }
                            
                            Text("Invite others to your Band with this code").font(Font.callout)
                        }
                        
                        
                        Spacer()
                    }
                }
                .padding(32.00)
                .background(Color.white)
                .border(Color.black.opacity(0.05))
                .cornerRadius(8)
                .shadow(color: Color(red: 0.00, green: 0.00, blue: 0.00).opacity(0.15),
                         radius: 8.68, x: 0.00, y: 7.35)
            }
        }.padding(16)
    }
}

struct BandList_Previews: PreviewProvider {
    static var previews: some View {
        BandList()
    }
}
