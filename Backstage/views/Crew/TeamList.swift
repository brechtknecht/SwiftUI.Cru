//
//  TeamList.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct TeamList: View {
    
    @ObservedObject var user : UserDB = realmSync.user
    
    var body: some View {
        
        VStack {
            let user = realmSync.user
            ForEach(user.teams, id: \.self) { team in
                VStack (alignment: .leading) {
                    TeamIcon(teamName: "", cornerRadius: "top")
                    VStack {
                        VStack {
                            Text("\(team.name)").font(.title).fontWeight(.semibold)
                            Text("\(team.events.count) Zugehörige Verabredungen")
                        }
                        
                        HStack {
                            Spacer()

                            VStack (alignment: .center){
                                QRCodeView(url: team.teamRef)
                                
                                Button(action: {
                                    UIPasteboard.general.string = team.teamRef
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .fill(ColorManager.accent.opacity(0.05))
                                            .cornerRadius(12)
                                        HStack {
                                            Image(systemName: "doc.on.doc")
                                            Text("Copy Code to clipboard")
                                        }.padding(14)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }.padding(32.00)

                }
                .background(ColorManager.primaryLight)
                .addBorder(Color.black.opacity(0.15), width: 0.5, cornerRadius: 12)
                .cornerRadius(12)
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
