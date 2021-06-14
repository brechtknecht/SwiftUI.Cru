//
//  BandSignifierCard.swift
//  Backstage
//
//  Created by Felix Tesche on 30.05.21.
//

import SwiftUI
import CodeScanner

struct BandSignifierCard: View {
//    @State var bandID : String = realmSync.partitionValue
    @State var invalid: Bool = false
    
    @Binding var bandID : String
    
    @State private var isShowingScanner = false
    @State private var sheetNewBand: Bool = false
    
    var body: some View {
        VStack {
            Text("Create new band").font(.title3).fontWeight(Font.Weight.semibold)
            Spacer(minLength: 16)
            Button(action: {
                self.sheetNewBand = true
            }) {
                ButtonFullWidth(label: .constant("Register your band"));
            }
            .sheet(isPresented: $sheetNewBand,
                    onDismiss: { print("finished!") },
                    content: { NewBand() })
        }
        .padding(.all, 8)
        .background(ColorManager.backgroundForm)
        .cornerRadius(8.0)
        
        Spacer(minLength: 32)
        
        VStack {
            Text("Join existing band").font(.title3).fontWeight(Font.Weight.semibold)
            Spacer(minLength: 16)
            Button(action: {
                self.isShowingScanner = true
                
            }) {
                ButtonFullWidth(label: .constant("Scan Band Code"), icon: "qrcode.viewfinder");
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "kOIkTOpdaF7SbJtiwkEI3q0Z", completion: self.handleScan)
            }
            Text("or enter manually").font(Font.callout)
            
            TextField(LocalizedStringKey("Enter existing Band Code"),
                      text: $bandID,
                      onEditingChanged: { changing in
                        if !changing {
                            self.bandID = self.bandID.trimmingCharacters(in: .whitespacesAndNewlines)
                        } else {
                            self.invalid = false
                        }},
                      onCommit: self.setBandID)
                .padding(.all, 8)
                .background(Color.white)
                .cornerRadius(8.0)
                .font(.system(size: 14, design: .monospaced))
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
            
            Text("This is your unique Band ID, share it to let your other bandmembers come on board").font(Font.caption2)
        }
        .padding(.all, 8)
        .background(ColorManager.backgroundForm)
        .cornerRadius(8.0)
    }
    
    func handleScan (result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
            case .success(let decoded):
                realmSync.setPartitionValue(value: decoded)
                self.bandID = decoded
                
                self.setBandID()
            case .failure(let error):
                print("Scanner didnt work \(error)")
        }
    }
    
    struct NewBand: View {
        @Environment (\.presentationMode) var presentationMode
        
        @State var bandName : String = ""
        @State var username : String = ""
        
        @EnvironmentObject var userStore : UserStore
        @EnvironmentObject var bandStore : BandStore

        var body: some View {
            
            NavigationView {
                VStack {
                    VStack {
                        Form {
                            Section(
                                header: Text("Band Info")
                            ){
                                TextField("Band Name",text: $bandName)
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
                                let bandRef = Utilities.helpers.generateBandID()
                                
                                let userID = realmSync.getCurrentUser()
                                print("CURRENTUSERID \(userID)")
                                // Create Band and attach the UserID as Admin
                                // @Hook:bandStore:create
                                
                                let bandID = UUID().hashValue
                                bandStore.create(bandID: bandID, name: self.bandName, bandRef: bandRef)
                                
                                realmSync.setPartitionValue(value: bandRef)
                                
                                let band = bandStore.findByPartitionValue(partitionValue: bandRef)
                                
//                                userStore.update(userID: userID, band: band)
                                userStore.addBand(userID: userID, band: band)
                                
                                
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                ButtonFullWidth(label: .constant("Create new Band"));
                            }
                        }.padding(.horizontal, 16)
                    }
                }
                .navigationTitle(Text("Create new Band"))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    
    func setBandID() -> Void {
        print("\(self.bandID)")
        realmSync.setPartitionValue(value: self.bandID)
    }
}
