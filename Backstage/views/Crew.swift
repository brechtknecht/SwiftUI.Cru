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
            }
            .padding(.horizontal, 8)
            .navigationTitle(Text("Crew"))   
        }
        
    }
}

struct Crew_Previews: PreviewProvider {
    static var previews: some View {
        Crew()
    }
}
