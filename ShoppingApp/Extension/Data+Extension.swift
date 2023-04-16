//
//  Data+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import Foundation

extension Data {
    
    func decodeData<T: Decodable>() -> T? {
        try? JSONDecoder().decode(T.self, from: self)
//        do {
//            let decodedData = try JSONDecoder().decode(T.self, from: self)
//            return decodedData
//        } catch {
//            return nil
//        }
    }
}
