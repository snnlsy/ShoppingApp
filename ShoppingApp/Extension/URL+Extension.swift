//
//  URL+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

extension URL {

    typealias ImageResult = (Result<UIImage?, APIError>) -> Void
    typealias JsonResult<T> = (Result<T, APIError>) -> Void
    
    func fetchImage(completion: @escaping ImageResult) {
        ImageManager.shared.checkCache(from: self) { image in
            if let image = image {
                completion(.success(image))
                return
            }
            NetworkManager.shared.fetchData(url: self) { imageResponse in
                switch imageResponse {
                case .success(let data):
                    let image = ImageManager.shared.dataToImage(data: data)
                    if let image = image {
                        ImageManager.shared.cache(imageUrl: self, image: image)
                    }
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchJsonData<T: Decodable>(completion: @escaping JsonResult<T>) {
        NetworkManager.shared.fetchData(url: self) { dataResponse in
            switch dataResponse {
            case .success(let data):
                do {
                    let res = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(res))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
