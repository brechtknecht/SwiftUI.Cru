//
//  ButtonFullWidth.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct ButtonFullWidth: View {
    @State var label: String
    @State var backgroundColor : Color = ColorManager.primaryDark
    @State var icon : String = ""
    
    var body: some View {
        HStack {
            if(!icon.isEmpty) {
                Image(systemName: icon)
            }
            Text("\(label)")
                .fontWeight(.semibold)
        }
        .frame(maxWidth: nil)
        .padding(14)
        .foregroundColor(ColorManager.primaryLight)
        .background(ColorManager.primaryDark)
        .cornerRadius(8)
    }
}

struct ButtonFullWidth_Previews: PreviewProvider {
    @State static var label = "Testtext aus Preview"
    
    static var previews: some View {
        ButtonFullWidth(label: label)
    }
}
