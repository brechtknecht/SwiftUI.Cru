//
//  Utils.swift
//  Backstage
//
//  Created by Felix Tesche on 08.12.20.
//

import Foundation
import SwiftUI

class Utilities {
    
    // Makes the Utilities functions available via Uilities.helpers.(funcionname)
    static var helpers: Utilities = {
        return Utilities()
    }()
    
    
    // Returns the Path of the documentRoot
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Loads previously saved images from the documentRoot via String UUID
    func loadImageFromUUID (imageUUID: String) -> UIImage {
        let documentsPath = getDocumentsDirectory()
        let imageURL = URL(fileURLWithPath: documentsPath.absoluteString).appendingPathComponent(imageUUID)
        return UIImage(contentsOfFile: imageURL.path) ?? UIImage()
    }
}


// Extends UIImage for saving selected Images and obtaining original orientation
extension UIImage {
    func png(isOpaque: Bool = true) -> Data? { flattened(isOpaque: isOpaque).pngData() }
    func flattened(isOpaque: Bool = true) -> UIImage {
        if imageOrientation == .up { return self }
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in draw(at: .zero) }
    }
}
