//
//  Paddings.swift
//  Backstage
//
//  Created by Felix Tesche on 13.01.21.
//

import Foundation
import CoreGraphics
import SwiftUI

struct Paddings {
    // Static Paddings based on 8-point grid
    static let small    : CGFloat  = 4.0
    static let medium   : CGFloat  = 8.0
    static let large    : CGFloat  = 16.0
    static let xlarge   : CGFloat  = 32.0
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
