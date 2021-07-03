//
//  Attendants.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI
import RealmSwift

struct Attendants: View {
    @State var attendants : RealmSwift.List<UserDB>
    
    var body: some View {
        ForEach(Array(attendants.enumerated()), id: \.offset) { index, attendant in
            HStack {
                Image("_placeholder-person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .offset(x: (-32.00 * CGFloat(index)), y: 0)
                    .overlay(
                        Circle().stroke(ColorManager.primaryLight, lineWidth: 2)
                            .offset(x: (-32.00 * CGFloat(index)), y: 0)
                    )
                    .frame(width: 54.00, height: 54.00)
            }.offset(x: 12.00, y: 0)
            }
        }
}
