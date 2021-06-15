//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

enum ActiveCrewSheet: Identifiable {
    case bands, userPreferences
    
    var id: Int {
        hashValue
    }
}


struct Crew: View {
    @State var partitionValueInput : String
    @State var invalid: Bool = false
    
    @State var activeSheet: ActiveCrewSheet?
    
    @State private var userSheet = false
    @State private var sheetNewBand: Bool = false
    
    @State private var username: String = ""
    
    @EnvironmentObject var bandStore : BandStore
    @EnvironmentObject var realmSync : RealmSync
    
    @EnvironmentObject var userStore : UserStore
    
    var user : UserDB {
        let currentUserID = realmSync.getCurrentUser()
        return userStore.findByID(id: currentUserID)
    }
        
    var body: some View {
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
                        
                        QRCodeView(url: realmSync.partitionValue)
                        
                        Text("Invite others to your Band with tis code").font(Font.callout)
                                                        
                            
                        .navigationBarItems(
                            leading: Menu("Deine Bands") {
                                let userID = realmSync.getCurrentUser()
                                let user = userStore.findByID(id: userID) ?? UserDB()
                                
                                ForEach(user.bands, id: \.self) { band in
                                    Button(action: {
                                        realmSync.setPartitionValue(value: band.bandRef)
                                    }) {
                                        HStack {
                                            if(band.bandRef == realmSync.partitionValue) {
                                                Image(systemName: "checkmark")
                                            }
                                            Text("\(band.name)").fontWeight(.semibold)
                                        }
                                    }
                                }
                                Button(action: {
                                    activeSheet = .bands
                                }) {
                                    HStack {
                                        Image(systemName: "plus")
                                        Text("New Band").fontWeight(.semibold)
                                    }
                                }
                            },
                            trailing: Button(action: {
                                activeSheet = .userPreferences
                            }) {
                                HStack {
                                    Image(systemName: "person.circle")
                                    Text("Profil")
                                }
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, 8)
            .navigationTitle(Text("Your Groups"))
        }.sheet(item: $activeSheet) { item in
            switch item {
            case .bands:
                BandSignifierCard(bandID: self.$partitionValueInput)
            case .userPreferences:
                UserPreferencesView(bandID: $partitionValueInput)
            }
        }
    }
}
