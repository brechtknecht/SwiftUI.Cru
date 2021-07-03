//
//  TeamSignifierCard.swift
//  Backstage
//
//  Created by Felix Tesche on 30.05.21.
//

import SwiftUI
import CodeScanner

struct TeamSignifierCard: View {
    @State var invalid: Bool = false
    @Binding var teamID : String
        
    @State private var isShowingScanner = false
    @State private var sheetNewTeam: Bool = false
    
    @EnvironmentObject var userStore : UserStore
    @EnvironmentObject var teamStore : TeamStore
    
    @ObservedObject var user : UserDB = realmSync.user
    
    var body: some View {
        VStack {
            Text("Create new team").font(.title3).fontWeight(Font.Weight.semibold)
            Spacer(minLength: 16)
            Button(action: {
                self.sheetNewTeam = true
            }) {
                ButtonFullWidth(label: "Register your team");
            }
            .sheet(isPresented: $sheetNewTeam,
                    onDismiss: { print("finished!") },
                    content: { NewTeam() })
        }
        .padding(.all, 8)
        .background(ColorManager.backgroundForm)
        .cornerRadius(8.0)
        
        Spacer(minLength: 32)
        
        VStack {
            Text("Join existing Team").font(.title3).fontWeight(Font.Weight.semibold)
            Spacer(minLength: 16)
            Button(action: {
                self.isShowingScanner = true
                
            }) {
                ButtonFullWidth(label: "Scan Team Code", icon: "qrcode.viewfinder");
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "kQiMlPaIu6WVRCcDtH6xs5Kn", completion: self.handleScan)
            }
            Text("or enter manually").font(Font.callout)
            
            TextField(LocalizedStringKey("Enter existing Team Code"),
                      text: $teamID,
                      onEditingChanged: { changing in
                        if !changing {
                            self.teamID = self.teamID.trimmingCharacters(in: .whitespacesAndNewlines)
                        } else {
                            self.invalid = false
                        }},
                      onCommit: self.setTeamID)
                .padding(.all, 8)
                .background(ColorManager.primaryLight)
                .cornerRadius(8.0)
                .font(.system(size: 14, design: .monospaced))
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
            
            Text("This is your unique Team ID, share it to let your other team-members come on board").font(Font.caption2)
        }
        .padding(.all, 8)
        .background(ColorManager.backgroundForm)
        .cornerRadius(8.0)
    }
    
    func handleScan (result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
            case .success(let decoded):
                let team = teamStore.findByTeamReference(referenceString: decoded)
                            
                if(team == nil) { print("No Team found for your scan. — DECODED VALUE \(decoded)"); return }
                
                print("SCAN ADDING TEAM \(team)")
                userStore.addTeam(user: user, team: team)
                teamStore.addMember(team: team, member: user)
                
                
            case .failure(let error):
                print("Scanner didnt work \(error)")
        }
    }
    
    
    
    
    func setTeamID() -> Void {
        print("\(self.teamID)")
        realmSync.setPartitionValue(value: self.teamID)
    }
}
