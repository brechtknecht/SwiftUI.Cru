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
      
         HStack(spacing: 0){
            ForEach(Array(attendants.enumerated()), id: \.offset) { index, attendant in
               if(index < 5) {
                  Image("_placeholder-person")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .clipShape(Circle())
                     .shadow(radius: 6)
                     .overlay(
                        Circle().stroke(ColorManager.primaryLight, lineWidth: 2)
                     )
                     .frame(width: 42.00, height: 72.00)
               } else if(index == attendants.endIndex - 1) {
                  Text("+ \(attendants.count - 5) Personen")
                     .padding(.leading, 16)
               }
            }
         }
         .padding(.horizontal, 16)
         .frame(width: .infinity)
      }
}
