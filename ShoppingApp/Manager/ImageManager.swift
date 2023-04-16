//
//  ImageManager.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

final class ImageManager {
    
    static let shared = ImageManager()
    private init() {}
    
    private let imageCache = NSCache<NSString, UIImage>()

    func cache(imageUrl: URL, image: UIImage) {
        let cacheKey: NSString = imageUrl.absoluteString as NSString
        imageCache.setObject(image, forKey: cacheKey)
    }
    
    func checkCache(from imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: imageUrl.absoluteString)
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        completion(nil)
    }
    
    func dataToImage(data: Data) -> UIImage? {
        if let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
