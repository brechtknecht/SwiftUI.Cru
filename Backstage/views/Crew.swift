//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Crew: View {
    
    @State var partitionValueInput : String
    @State var invalid: Bool = false
    
    @EnvironmentObject var bandStore : BandStore
    @EnvironmentObject var realmSync : RealmSync
        
    var body: some View {
        NavigationView {
            ScrollView {
                if(realmSync.partitionValue.isEmpty) {
                    BandSignifierCard(bandID: $partitionValueInput)
                } else {
                    Text("You are logged in with")
                    
                    Button(action: {
                        print("\(realmSync.partitionValue)")
                        UIPasteboard.general.string = realmSync.partitionValue
                    }) {
                        VStack {
                            Text("\(realmSync.partitionValue)")
                            HStack {
                                Text("Copy to clipboard")
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    }
                    
                    Text("\(bandStore.findByPartitionValue(partitionValue: realmSync.partitionValue)?.name ?? "")")
                    
                    QRCodeView(url: realmSync.partitionValue)
                    
                    Text("Invite others to your Band with tis code").font(Font.callout)
                        .navigationBarItems(trailing: Button("Logout") {
                            realmSync.logout()
                            self.partitionValueInput = realmSync.partitionValue
                        }
                    )
                }
                
            }
            .padding(.horizontal, 8)
            .navigationTitle(Text("Your Groups"))   
        }
        
    }
}
