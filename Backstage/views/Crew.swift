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
    
    @State private var username: String = ""
    
    @EnvironmentObject var bandStore : BandStore
    @EnvironmentObject var realmSync : RealmSync
    
    @EnvironmentObject var userStore : UserStore
        
    var body: some View {
        
        Button("Display UserData") {
            let userID = realmSync.getCurrentUser()
            let user = userStore.findByID(id: userID) ?? UserDB()
            print("\(user)")
        }
        NavigationView {
            ScrollView {
                if(realmSync.getCurrentUser() == 0) {
                    
                    TextField("Enter your name", text: $username)
                    Button("Create new User") {
                        let id = UUID().hashValue
                        // Creates User first to then ref the UserID
                        // @Hook:userStore:create
                        userStore.create(userID: id, name: username)
                        
                        realmSync.setCurrentUser(value: id)
                    }
                } else {
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
                            .navigationBarItems(
                                leading: Menu("Options") {
                                    let userID = realmSync.getCurrentUser()
                                    let user = userStore.findByID(id: userID) ?? UserDB()
                                    
                                    
                                    ForEach(user.bands, id: \.self) { band in
                                        Button(action: {
                                            realmSync.setPartitionValue(value: band.bandRef)
                                        }) {
                                            VStack {
                                                Text("\(band.name)").fontWeight(.semibold)
                                                Text("\(band.bandRef) (REF)")
                                            }
                                        }
                                        
                                    }
                                },
                                trailing: Button("Logout") {
                                realmSync.logout()
                                self.partitionValueInput = realmSync.partitionValue
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, 8)
            .navigationTitle(Text("Your Groups"))   
        }
        
    }
}
