//
//  CEditButton.swift
//  Backstage
//
//  Created by Felix Tesche on 12.12.20.
//

import SwiftUI

struct CEditButton: View {
    
    @Environment(\.editMode) var editMode
    
    private var isEditing : Bool {
        editMode?.wrappedValue.isEditing == false
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                editMode?.wrappedValue = isEditing ? .active : .inactive
            }
        },
        label: {
            isEditing ? Text("Bearbeiten") : Text("Fertig") 
        })
    }
}
