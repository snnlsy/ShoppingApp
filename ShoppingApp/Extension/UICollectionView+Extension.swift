//
//  UICollectionView+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

extension UICollectionView {
    
    func reloadDataAsync() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
    
    func register(_ type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable CollectionViewCell")
        }
        return cell
    }
}
