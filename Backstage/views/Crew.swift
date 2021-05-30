//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Crew: View {
    
    @State var partitionValueInput : String = realmSync.partitionValue
    @State var invalid: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                if(self.partitionValueInput.isEmpty) {
                    BandSignifierCard(bandID: $partitionValueInput)
                } else {
                    Text("You are logged in with")
                    Text("\(realmSync.partitionValue)")
                    QRCodeView(url: realmSync.partitionValue)
                    Text("Invite others to your Band with tis code").font(Font.callout)
                        .navigationBarItems(trailing: Button("Logout") {
                            realmSync.setPartitionValue(value: "")
                            self.partitionValueInput = realmSync.partitionValue
                        }
)
                }
                
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
