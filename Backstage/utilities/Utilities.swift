//
//  Utils.swift
//  Backstage
//
//  Created by Felix Tesche on 08.12.20.
//

import Foundation
import SwiftUI

class Utilities {
    
    static var helpers: Utilities = {
        return Utilities()
    }()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadImageFromUUID (imageUUID: String) -> UIImage {
        let documentsPath = getDocumentsDirectory()
        let imageURL = URL(fileURLWithPath: documentsPath.absoluteString).appendingPathComponent(imageUUID)
        return UIImage(contentsOfFile: imageURL.path) ?? UIImage()
    }
}


extension UIImage {
    func png(isOpaque: Bool = true) -> Data? { flattened(isOpaque: isOpaque).pngData() }
    func flattened(isOpaque: Bool = true) -> UIImage {
        if imageOrientation == .up { return self }
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in draw(at: .zero) }
    }
}
