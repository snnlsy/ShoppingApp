//
//  UIImageView+Extension.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

extension UIImageView {
    
    func load(from url: URL, raw: Bool = false) {
        loadImage(url: url, raw: raw)
    }
    
    func load(from string: String, raw: Bool = false) {
        if let url = URL(string: string) {
            loadImage(url: url, raw: raw)
        }
    }
    
    private func loadImage(url: URL, raw: Bool = false) {
        var imageUrlStr = url.absoluteString
        if raw {
            imageUrlStr += "?raw=true"
        }
        if let imageUrl = URL(string: imageUrlStr) {
            imageUrl.fetchImage { image in // weak
                switch image {
                case .success(let img):
                    DispatchQueue.main.async { [weak self] in
                        self?.image = img
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}
