//
//  Utils.swift
//  Backstage
//
//  Created by Felix Tesche on 08.12.20.
//

import Foundation

class Utilities {
    
    static var helpers: Utilities = {
        return Utilities()
    }()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

