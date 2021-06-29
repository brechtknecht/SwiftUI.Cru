//
//  DateTag.swift
//  Backstage
//
//  Created by Felix Tesche on 29.06.21.
//

import SwiftUI

struct DateTag: View {
    @State var date : Date
    
    @State var stringDay : String = ""
    @State var stringMonth : String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("\(stringDay)")
                    .font(.title)
                Text("\(stringMonth)")
                    .textCase(.uppercase)
                    .padding(.horizontal)
                    .foregroundColor(Color.red)
            }
            .onAppear(
                perform: {
                    let dayFormatter = DateFormatter()
                    dayFormatter.dateFormat = "d"
                    
                    self.stringDay = dayFormatter.string(from: date)
                    
                    let monthFormatter = DateFormatter()
                    monthFormatter.dateFormat = "MMM"
                    
                    self.stringMonth = monthFormatter.string(from: date)
                }
            )
        }
        .padding(.horizontal, 12.00)
        .padding(.vertical, 17.00)
        .background(Color.white)
        .cornerRadius(8)
    }
}
