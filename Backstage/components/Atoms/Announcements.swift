//
//  Announcements.swift
//  Backstage
//
//  Created by Felix Tesche on 06.07.21.
//

import SwiftUI

struct Announcements: View {
    @State var name : String
    @State var text : String
    @State var imageName : String
    
    var body: some View {
        VStack {
            HStack {
                Image("\(imageName)")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .clipShape(Circle())
                   .shadow(radius: 6)
                   .overlay(
                      Circle().stroke(ColorManager.responsiveWhite, lineWidth: 2)
                   )
                   .frame(width: 42.00, height: 56.00)
                Text("\(name)")
                Spacer()
            }.padding(.horizontal, 8.00)
            Text("\(text)")
        }
        .padding(.all, 16.00)
        .background(ColorManager.responsiveWhite)
        .cornerRadius(12.00)
    }
}

//struct Announcements_Previews: PreviewProvider {
//    static var previews: some View {
//        Announcements()
//    }
//}
