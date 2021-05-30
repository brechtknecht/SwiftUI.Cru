//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Crew: View {
    
    @State var bandIdentifierInput : String = ""
    @State var invalid: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                BandSignifierCard()
                    .background(ColorManager.backgroundForm)
                    .cornerRadius(8.0)
            }
            .padding(.horizontal, 16)
            .navigationTitle(Text("Crew"))   
        }
        
    }
}

struct Crew_Previews: PreviewProvider {
    static var previews: some View {
        Crew()
    }
}
