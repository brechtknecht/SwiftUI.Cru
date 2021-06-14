//
//  NewBand.swift
//  Backstage
//
//  Created by Felix Tesche on 14.06.21.
//

import SwiftUI

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
