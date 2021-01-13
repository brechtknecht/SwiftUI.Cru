//
//  BindingExtension.swift
//  Backstage
//
//  Created by Felix Tesche on 10.12.20.
//

import SwiftUI


// toNonOptionalValue() - Generic variant for all types add types like schema below
// Call with $varname.toNonOptionalString() to convert to optional value in SwiftUI

extension Binding {
    func toNonOptionalValue<T> (fallback: T) -> Binding<T> where Value == T? {
        Binding<T>(get: {
            self.wrappedValue ?? fallback
        }, set: {
            self.wrappedValue = $0
        })
    }
    
    func toNonOptionalString (fallback: String = "") -> Binding<String> where Value == String? {
        toNonOptionalValue(fallback: fallback)
    }
    
    func toNonOptionalDate (fallback: Date = Date()) -> Binding<Date> where Value == Date? {
        toNonOptionalValue(fallback: fallback)
    }
}
