//
//  UsesAutoLayout.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
