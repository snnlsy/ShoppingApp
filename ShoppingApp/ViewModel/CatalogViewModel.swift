//
//  CatalogViewModel.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import Foundation

protocol CatalogViewModelProtocol: AnyObject {
    func reloadData()
    func updateCartActive()
}

final class CatalogViewModel {
    weak var delegate: CatalogViewModelProtocol?
    
    func config() {
        fetchData()
    }
    
    var itemModelListCount: Int {
        itemModelList.count
    }
    
    var totalCountInCart: String {
        String(CartDataManager.shared.totalItemsInCart)
    }
    
    var isCartActive: Bool {
        get {
            let totalItemsInCart = CartDataManager.shared.totalItemsInCart
            return totalItemsInCart <= 0 ? false : true
        }
    }
        
    private(set) var itemModelList: [ItemModel] = [] {
        didSet {
            delegate?.reloadData()
            delegate?.updateCartActive()
        }
    }
    
    func increaseItemCount(item: String) {
        CartDataManager.shared.increase(item: item)
        delegate?.updateCartActive()
    }
    
    private func fetchData() {
        guard let catalogUrl = URL(string: K.Api.url) else { return }
        catalogUrl.fetchJsonData { [weak self] (result: Result<[ItemModel], APIError>) in
            switch result {
            case .success(let res):
                CatalogDataManager.shared.setItemModelList(itemModelList: res)
                self?.itemModelList = res
            case .failure(let err):
                print(err)
            }
        }
    }
}
