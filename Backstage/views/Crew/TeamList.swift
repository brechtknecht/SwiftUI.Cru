//
//  TeamList.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct TeamList: View {
    
    @EnvironmentObject var realmSync : RealmSync
    
    var body: some View {
        
        VStack {
            ForEach(self.realmSync.user.teams, id: \.self) { team in
                VStack (alignment: .leading) {
                    HStack {
                        Text("\(team.name)").font(.title).fontWeight(.semibold)
                        Spacer()
                        TeamIcon()
                    }
                    
                    HStack {
                        Text("\(team.events.count) Zugehörige Verabredungen")
                    }
                    
                    HStack {
                        Spacer()

                        VStack (alignment: .center){
                            QRCodeView(url: team.teamRef)
                            
                            Button(action: {
                                UIPasteboard.general.string = team.teamRef
                            }) {
                                VStack {
                                    HStack {
                                        Text("Copy to clipboard")
                                        Image(systemName: "doc.on.doc")
                                    }
                                }
                            }
                            
                            Text("Invite others to your Team with this code").font(Font.callout)
                        }
                        
                        
                        Spacer()
                    }
                }
                .padding(32.00)
                .background(ColorManager.primaryLight)
                .border(Color.black.opacity(0.05))
                .cornerRadius(8)
                .shadow(color: Color(red: 0.00, green: 0.00, blue: 0.00).opacity(0.15),
                         radius: 8.68, x: 0.00, y: 7.35)
            }
        }.padding(16)
    }
}

struct TeamList_Previews: PreviewProvider {
    static var previews: some View {
        TeamList()
    }
}
