//
//  BandSignifierCard.swift
//  Backstage
//
//  Created by Felix Tesche on 30.05.21.
//

import SwiftUI

struct BandSignifierCard: View {
    @State var bandID : String = ""
    @State var invalid: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                print("do something!")
            }) {
                ButtonFullWidth(label: .constant("Create new Band"));
            }
            
            Button(action: {
                print("do something!")
            }) {
                ButtonFullWidth(label: .constant("Scan Band Code"));
            }
            
            
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
                .autocapitalization(.none)
        }
        .padding(.all, 8)
    }
    
    
    func setBandID() -> Void {
        print("\(self.bandID)")
        realmSync.setPartitionValue(value: self.bandID)
    }
}
