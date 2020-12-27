//
//  Overview.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Overview: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading){
                    ZStack (){
                        Rectangle()
                            .foregroundColor(ColorManager.primaryDark)
                            .cornerRadius(4)
                            .frame(height: 175, alignment: .leading)
                            .padding(8)

                        Text("\(bandDummyData.name)")
                            .font(.title)
                            .fontWeight(.bold)
                            .tracking(1)
                            .padding(.horizontal, 16)
                            .foregroundColor(ColorManager.primaryLight)
                        
                    }
                    
                    Section {
                        Text("Nächste Veranstaltungen")
                            .font(.headline)
                            .padding(.horizontal, 16)
                    }
                    
                    Section {
                        Text("Nächste Proben")
                            .font(.headline)
                            .padding(.horizontal, 16)
                    }
                    
                    
                    
                }
            }
            .navigationBarTitle(
                Text("Übersicht")
            )
        }
        
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
