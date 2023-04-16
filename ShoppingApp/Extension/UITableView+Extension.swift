//
//  UITableView+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

extension UITableView {
    
    func reloadDataAsync() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
    
    func register(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable TableViewCell")
        }
        return cell
    }
}
