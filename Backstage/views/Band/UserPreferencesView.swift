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
    @EnvironmentObject var teamStore    : TeamStore
    @EnvironmentObject var eventStore   : EventStore
    
    @Binding var teamID : String
    
    @EnvironmentObject var realmSync : RealmSync
    
    var body: some View {
        NavigationView {
            Form {
                Text("\(self.realmSync.user.name)")

                Section (header: Text("Teams")) {
                    ForEach(self.realmSync.user.teams, id: \.self) { team in
                        VStack {
                            Text("\(team.name)").fontWeight(.semibold)
                            Text("\(team.teamRef) (REF)")
                        }
                    }.onDelete(perform: delete)
                }
                
                Button("Display UserData") {
                    let userID = realmSync.getCurrentUser()
//                    let user = userStore.findByID(id: userID) ?? UserDB()
//                    print("\(user)")
                }
                
                Button("Display all Teams") {
                    teamStore.teams
                    print("\(teamStore.teams)")
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
            userStore.removeTeam(userID: self.realmSync.user.id, index: index)
        })
    }
}
