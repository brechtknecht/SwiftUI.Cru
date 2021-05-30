//
//  User.swift
//  Backstage
//
//  Created by Felix Tesche on 24.05.21.
//

import Foundation
import SwiftUI
import RealmSwift

struct User: Identifiable, Hashable {
    let id      : Int
    let _id     : Int
    let name    : String
    let bandID  : String
}

extension User {
    init(userDB: UserDB) {
        id      = userDB.id
        _id     = userDB._id
        name    = userDB.name
        bandID  = userDB.bandID
    }
}
