//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Crew: View {
    
    @State var bandIdentifierInput : String = ""
    @State var invalid: Bool = false
    
    var body: some View {
        Text("Henlo World")
        Text("\(realmSync.partitionValue)")
        
        Form {
            TextField(LocalizedStringKey("Firstname"),
                  text: $bandIdentifierInput,
                  onEditingChanged: { changing in
                    if !changing {
                        self.bandIdentifierInput = self.bandIdentifierInput.trimmingCharacters(in: .whitespacesAndNewlines)
                    } else {
                        self.invalid = false
                    }},
                  onCommit: self.setBandID)
        }
    }
    
    func setBandID() -> Void {
        print("\(self.bandIdentifierInput)")
        realmSync.setPartitionValue(value: self.bandIdentifierInput)
    }
}

struct Crew_Previews: PreviewProvider {
    static var previews: some View {
        Crew()
    }
}
