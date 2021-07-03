//
//  TeamStore.swift
//  Backstage
//
//  Created by Felix Tesche on 25.05.21.
//

import Foundation
import RealmSwift

final class TeamStore: ObservableObject {
    private var results: Results<TeamDB>
    
    var teams: [Team] {
        results.map(Team.init)
    }
    
    init(realm: Realm) {
        results = realm.objects(TeamDB.self)
    }
    

    func findByID (id: Int) -> TeamDB! {
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            return try Realm(configuration: configuration).object(ofType: TeamDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func findByTeamReference (referenceString: String) -> TeamDB! {
        do {
            let partitionValue = "all-the-data"
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let predicate = NSPredicate(format: "teamRef = %@", referenceString as String)
            
            return try Realm(configuration: configuration).objects(TeamDB.self).filter(predicate).first
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

}

// MARK: - CRUD Actions
extension TeamStore {
    func create(teamID: Int, name: String, teamRef: String) {
        
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            let refDB = TeamDB()
            
            refDB.id = teamID
            refDB._id = teamID
            refDB.name = name
            refDB.teamRef = teamRef
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func addEvent(team: TeamDB? = nil, event: EventDB? = nil) {
        if(event == nil)        { print("Cannot add Event to Team — event parameter was not provided"); return }
        if(team  == nil)        { print("Cannot add Event to Team — Previous Team was not found"); return}
                
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            try! realm.write {
                team!.events.append(event!)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func addMember(team: TeamDB? = nil, member: UserDB? = nil) {
        if(team == nil)         { print("Cannot add Member to Team — team parameter was not provided"); return }
        if(member == nil)       { print("Cannot add Member to Team — user to add was not provided"); return}
        
        let previousTeam = team
        
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            try realm.write {
                let updatedTeam = TeamDB()
                
                if(!previousTeam!.events.isEmpty){
                    updatedTeam.members.append(objectsIn: previousTeam!.members)
                }
                updatedTeam.members.append(member!)
                
                realm.create(TeamDB.self,
                     value: [
                        "_id"       : previousTeam!.id,
                        "id"        : previousTeam!._id,
                        "members"   : updatedTeam.members
                     ],
                     update: .modified)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let partitionValue = "all-the-data"
            
            let user = app.currentUser!
            let configuration = user.configuration(partitionValue: partitionValue)
            
            let realm = try Realm(configuration: configuration)
            
            indexSet.forEach ({ index in
                try! realm.write {
                    realm.delete(self.results[index])
                }
            })
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

