//
//  NewTeam.swift
//  Backstage
//
//  Created by Felix Tesche on 14.06.21.
//

import SwiftUI

struct NewTeam: View {
    @Environment (\.presentationMode) var presentationMode
    
    @State var teamName : String = ""
    @State var username : String = ""
    
    @EnvironmentObject var userStore : UserStore
    @EnvironmentObject var teamStore : TeamStore

    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Form {
                        Section(
                            header: Text("Team Info")
                        ){
                            TextField("Team Name",text: $teamName)
                        }
                        Section {
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(Color.green)
                                Text("Already existing Events will be imported")
                            }
                        }
                        
                        Section(
                            header: Text("Info about you")
                        ){
                            TextField("Your name",text: $username)
                        }
                    }
                    Spacer()
                    Section {
                        Button(action: {
                            let teamRef = Utilities.helpers.generateTeanID()
                            
                            let userID = realmSync.getCurrentUser()
                            
                            let user = realmSync.user
                            
                            print("CURRENTUSERID \(userID)")
                            // Create Team and attach the UserID as Admin
                            // @Hook:teamStore:create
                            
                            let teamID = UUID().hashValue
                            teamStore.create(teamID: teamID, name: self.teamName, teamRef: teamRef)
                            
                            realmSync.setPartitionValue(value: teamRef)
                            
                            let team = teamStore.findByID(id: teamID)
                            
                            userStore.addTeam(user: user, team: team)
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            ButtonFullWidth(label: .constant("Create new Team"));
                        }
                    }.padding(.horizontal, 16)
                }
            }
            .navigationTitle(Text("Create new Team"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}
