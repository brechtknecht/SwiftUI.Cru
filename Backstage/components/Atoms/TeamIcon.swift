//
//  TeamIcon.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct TeamIcon: View {
    
    @State var teamName : String
    @State var cornerRadius : String
    
    var body: some View {
        ZStack {
            if(cornerRadius == "top") {
                Rectangle()
                    .fill(ColorManager.accent)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            if(cornerRadius == "bottom") {
                Rectangle()
                    .fill(ColorManager.accent)
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            }
            Text(teamName.uppercased())
                .font(.subheadline)
                .fontWeight(.bold)
                .tracking(1.54)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.white)
                .padding(.vertical, 4)
        }
    }
}

struct TeamIcon_Previews: PreviewProvider {
    static var previews: some View {
        TeamIcon(teamName: "Random", cornerRadius: "bottom")
    }
}
