//
//  Crew.swift
//  Backstage
//
//  Created by Felix Tesche on 06.12.20.
//

import SwiftUI

struct Crew: View {
    var body: some View {
        Text("Henlo World")
        Text("\(realmSync.partitionValue)")
    }
}

struct Crew_Previews: PreviewProvider {
    static var previews: some View {
        Crew()
    }
}
