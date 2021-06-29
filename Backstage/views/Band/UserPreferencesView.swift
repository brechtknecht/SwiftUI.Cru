//
//  UserPreferencesView.swift
//  Backstage
//
//  Created by Felix Tesche on 14.06.21.
//

import SwiftUI

struct UserPreferencesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userStore    : UserStore
    @EnvironmentObject var bandStore    : BandStore
    @EnvironmentObject var eventStore   : EventStore
    
    @Binding var bandID : String
    
    @State var user : UserDB = realmSync.user
    
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
                    }.onDelete(perform: delete)
                }
                
                Button("Display UserData") {
                    let userID = realmSync.getCurrentUser()
                    let user = userStore.findByID(id: userID) ?? UserDB()
                    print("\(user)")
                }
                
                Button("Display all Bands") {
                    bandStore.bands
                    print("\(bandStore.bands)")
                }
                
                Button("Display all Events") {
                    eventStore.separatedEvents.count
                    print("---------EVENTCOUNT\(eventStore.separatedEvents.count)")
                }
            }.navigationBarTitle(Text("User Preferences"))
            
        }
    }
    
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach ({ index in
            userStore.removeBand(userID: self.user.id, index: index)
        })
    }
}
