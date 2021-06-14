//
//  UserPreferencesView.swift
//  Backstage
//
//  Created by Felix Tesche on 14.06.21.
//

import SwiftUI

struct UserPreferencesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userStore : UserStore
    @EnvironmentObject var bandStore : BandStore
    
    @Binding var bandID : String
    
    var user : UserDB {
        let currentUserID = realmSync.getCurrentUser()
        return userStore.findByID(id: currentUserID)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text("\(user.name)")

                Section (header: Text("Bands")) {
                    ForEach(user.bands, id: \.self) { band in
                        VStack {
                            Text("\(band.name)").fontWeight(.semibold)
                            Text("\(band.bandRef) (REF)")
                        }
                    }
                }
                
                Button("Aus Band Austreten") {
                    realmSync.logout()
                    self.bandID = realmSync.partitionValue
                }
                
                Button("Display UserData") {
                    let userID = realmSync.getCurrentUser()
                    let user = userStore.findByID(id: userID) ?? UserDB()
                    print("\(user)")
                }
            }.navigationBarTitle(Text("User Preferences"))
            
        }
    }
}
