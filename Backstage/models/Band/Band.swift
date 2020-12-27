//
//  Band.swift
//  Backstage
//
//  Created by Felix Tesche on 23.12.20.
//

import Foundation

class Band {
    @Published var id: UUID
    @Published var name: String
//    let members: [Member]
    @Published var members: String
    
    init(name: String, members: String) {
        self.id = UUID()
        self.name = name
        self.members = members
    }
    
}

var bandDummyData = Band(name: "Massenkarambulage", members: "Alfred, Robert, Tilli, Frankyboi")


