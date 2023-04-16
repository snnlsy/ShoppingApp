//
//  CatalogDataManager.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 30.03.2023.
//

import Foundation

final class CatalogDataManager {
    
    static let shared = CatalogDataManager()
    private init() {}
    
    private var itemModelList = [String: ItemModel]()
    
    func getItemModelList() -> [String: ItemModel] {
        itemModelList
    }
    
    func setItemModelList(itemModelList: [ItemModel]) {
        itemModelList.forEach { itemModel in
            self.itemModelList[itemModel.productName] = itemModel
        }
    }
}
