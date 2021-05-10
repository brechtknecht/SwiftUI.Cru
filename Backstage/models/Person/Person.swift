//
//  Person.swift
//  Backstage
//
//  Created by Felix Tesche on 16.01.21.
//

import Foundation

struct Person: Identifiable, Hashable {
    let _id          : Int
    let id          : Int
    let name        : String
    let role        : String
    let phoneNumber : String
}

extension Person {
    init(personDB: PersonDB) {
        _id         = personDB._id
        id          = personDB.id
        name        = personDB.name
        role        = personDB.role
        phoneNumber = personDB.phoneNumber
    }
}
