//
//  UIView+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

extension UIView {
    
    func addSubview(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
