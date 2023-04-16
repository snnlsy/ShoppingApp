//
//  DataManager.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import Foundation

final class CartDataManager {
    
    static let shared = CartDataManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let key = "CartDataManagerKey"
    private var itemCountsInCart = [String: Int]()
    
    func saveCartToUserDefaults() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        do {
            let data = try encoder.encode(itemCountsInCart)
            let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(key + ".plist")
            try data.write(to: fileUrl, options: .atomic)
        } catch {}
    }

    func loadCartFromUserDefaults() {
        let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(key + ".plist")
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = PropertyListDecoder()
            let dictionary = try decoder.decode([String: Int].self, from: data)
            itemCountsInCart = dictionary
        } catch {}
    }
    
//    func saveCartToUserDefaults() {
//        userDefaults.set(itemCountsInCart, forKey: key)
//    }
//
//    func loadCartFromUserDefaults() {
//        itemCountsInCart = userDefaults.object(forKey: key) as? [String: Int] ?? [:]
//    }
    
    func getItemCountsInCart() -> [String: Int] {
        itemCountsInCart
    }
    
    var totalItemsInCart: Int {
        itemCountsInCart.values.reduce(0, +)
    }
    
    func getCount(item: String) -> Int {
        guard let itemCount = itemCountsInCart[item] else { return 0 }
        return itemCount
    }
    
    func setCount(item: String, count: Int) {
        itemCountsInCart[item] = count
        saveCartToUserDefaults()
    }
    
    func increase(item: String) {
        let itemCount = getCount(item: item)
        itemCountsInCart[item] = itemCount + 1
        saveCartToUserDefaults()
    }
    
    func decrease(item: String) {
        let itemCount = getCount(item: item)
        let newItemCount = itemCount - 1
        itemCountsInCart[item] = newItemCount <= 0 ? nil : newItemCount
        saveCartToUserDefaults()
    }
    
    func emptyCart() {
        itemCountsInCart = [:]
        saveCartToUserDefaults()
    }
}
