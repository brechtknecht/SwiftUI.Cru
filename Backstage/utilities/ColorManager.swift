//
//  ColorManager.swift
//  Kickass
//
//  Created by Felix Tesche on 22.11.20.
//

import SwiftUI
    
struct ColorManager {
    // create static variables for custom colors
    static let primaryDark = Color("primary-dark")
    static let primaryLight = Color("primary-light")
    
    static let accent = Color("accent")
    
    static let backgroundForm = Color("background-form")
    
    static let success = Color("success")
    

    //... add the rest of your colors here
}

// Or you can use an extension
// this will allow you to just type .spotifyGreen and you wont have to use ColorManager.spotifyGreen
extension Color {
    static let primaryDark = Color("primary-dark")
    static let primaryLight = Color("primary-light")
    
    // ... add the rest of your colors here
}
