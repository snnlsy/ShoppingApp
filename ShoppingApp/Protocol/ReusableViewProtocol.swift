//
//  ReusableViewProtocol.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import Foundation

protocol ReusableViewProtocol {

    static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
