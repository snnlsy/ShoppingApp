//
//  CartViewModel.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 29.03.2023.
//

import Foundation

protocol CartViewModelProtocol: AnyObject {
    func reloadData()
    func setTotalPrice(_ totalPrice: String)
}

final class CartViewModel {
    
    weak var delegate: CartViewModelProtocol?
    
    private var itemCountsInCart = [String: Int]()
    private var itemModelList = [String: ItemModel]()
    private var itemsInCart = [ItemModel]()

    func config() {
        itemModelList = CatalogDataManager.shared.getItemModelList()
        itemCountsInCart = CartDataManager.shared.getItemCountsInCart()
        itemCountsInCart.forEach {
            if let item = itemModelList[$0.key] {
                itemsInCart.append(item)
            }
        }
    }
    
    var itemsInCartCount: Int {
        itemsInCart.count
    }
    
    var totalPrice: String {
        get {
            let price = itemsInCart.reduce(0.0) {
                guard let count = itemCountsInCart[$1.productName] else { return 0.0 }
                return $0 + ($1.productPrice * Double(count))
            }
            return String(format: "%.1f", price)
        }
    }
    
    func getItemsInCart() -> [ItemModel] {
        return itemsInCart
    }
    
    func getItemCount(itemModel: ItemModel) -> Int {
        if let count = itemCountsInCart[itemModel.productName] {
            return count
        }
        return 0
    }
    
    func decreaseItem(itemName: String) {
        CartDataManager.shared.decrease(item: itemName)
        itemCountsInCart = CartDataManager.shared.getItemCountsInCart()
                
        guard let _ = itemCountsInCart[itemName] else {
            itemsInCart.removeAll(where: { $0.productName == itemName })
            delegate?.reloadData()
            delegate?.setTotalPrice(totalPrice)
            return
        }
        delegate?.setTotalPrice(totalPrice)
    }
    
    func increaseItem(itemName: String) {
        CartDataManager.shared.increase(item: itemName)
        itemCountsInCart = CartDataManager.shared.getItemCountsInCart()
        delegate?.setTotalPrice(totalPrice)
    }
    
    func removeAllInCart() {
        CartDataManager.shared.emptyCart()
        itemCountsInCart = [:]
        itemsInCart = []
        delegate?.reloadData()
        delegate?.setTotalPrice(totalPrice)
    }
}
