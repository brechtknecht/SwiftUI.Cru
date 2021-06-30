//
//  TeamIcon.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct TeamIcon: View {
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 28, height: 28)
            .border(Color.black.opacity(0.05))
            .cornerRadius(4.0)
    }
}

struct TeamIcon_Previews: PreviewProvider {
    static var previews: some View {
        TeamIcon()
    }
}
