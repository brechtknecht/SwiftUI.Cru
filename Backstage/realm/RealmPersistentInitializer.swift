//
//  RealmPersistentInitializer.swift
//  Backstage
//
//  Created by Felix Tesche on 07.12.20.
//

import Foundation
import RealmSwift

class RealmPersistent {
    static func initializer() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch let err {
            fatalError("Failed to open Realm \(err.localizedDescription)")
        }
    }
}
