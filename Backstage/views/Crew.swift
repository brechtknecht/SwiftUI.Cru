//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

enum ActiveCrewSheet: Identifiable {
    case teams, userPreferences
    
    var id: Int {
        hashValue
    }
}


struct Crew: View {
    @State var partitionValueInput : String = "all-the-data"
    @State var invalid: Bool = false
    
    @State var activeSheet: ActiveCrewSheet?
    
    @State private var userSheet = false
    @State private var sheetNewTeam: Bool = false
    
    @EnvironmentObject var teamStore : TeamStore
    @EnvironmentObject var realmSync : RealmSync
    
    @EnvironmentObject var userStore : UserStore
    
    var body: some View {
        NavigationView {
            ScrollView {
                if(realmSync.getCurrentUser() == 0) {
                    UserCreation()
                } else {
                    TeamList()
                        .navigationBarItems(
                            leading: Menu("Deine Gruppen") {
                                let user = realmSync.user
                                
                                ForEach(user.teams, id: \.self) { team in
                                    Button(action: {
                                        realmSync.setPartitionValue(value: team.teamRef)
                                    }) {
                                        HStack {
                                            if(team.teamRef == realmSync.partitionValue) {
                                                Image(systemName: "checkmark")
                                            }
                                            Text("\(team.name)").fontWeight(.semibold)
                                        }
                                    }
                                }
                                Button(action: {
                                    activeSheet = .teams
                                }) {
                                    HStack {
                                        Image(systemName: "plus")
                                        Text("New Team").fontWeight(.semibold)
                                    }
                                }
                            },
                            trailing: Button(action: {
                                activeSheet = .userPreferences
                            }) {
                                let user = realmSync.user
                                HStack {
                                    Image(systemName: "person.circle")
                                    Text("\(user.name)")
                                }
                            }
                        )
                }
            }
            .navigationTitle(Text("Deine Cru"))
        }.sheet(item: $activeSheet) { item in
            switch item {
            case .teams:
                TeamSignifierCard(teamID: self.$partitionValueInput)
            case .userPreferences:
                UserPreferencesView(teamID: $partitionValueInput)
            }
        }
    }
}
