//
//  DetailViewModel.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 29.03.2023.
//

import Foundation

final class DetailViewModel {
    
    private var itemModelList = [String: ItemModel]()
    var currentCount: Int!
    var itemModel: ItemModel!
    
    func config(itemKey: String) {
        itemModelList = CatalogDataManager.shared.getItemModelList()
        itemModel = itemModelList[itemKey]
        currentCount = itemCount
    }

    var itemCount: Int {
        CartDataManager.shared.getCount(item: itemModel.productName)
    }
    
    var currentCountStr: String {
        String(currentCount)
    }
    
    func setCount(count: Int) {
        CartDataManager.shared.setCount(item: itemModel.productName, count: count)
    }
    
    func increaseItemCount() {
        currentCount += 1
    }
    
    func decreaseItemCount() {
        if currentCount == 0 { return }
        currentCount -= 1
    }
}
