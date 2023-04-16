//
//  ItemModel.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import Foundation

struct ItemModel: Decodable {
    let productName: String
    let productDescription: String
    let productPrice: Double
    let productImage: String
}
