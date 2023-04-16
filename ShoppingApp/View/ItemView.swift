//
//  ItemView.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

final class ItemView: UIView {

    @UsesAutoLayout
    var itemImageView = UIImageView()
    @UsesAutoLayout
    var nameLabel = UILabel()
    @UsesAutoLayout
    var priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupView() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = .systemGray5
        
        nameLabel.textAlignment = .center
        nameLabel.font = nameLabel.font.withSize(11)
        nameLabel.numberOfLines = 0
        
        priceLabel.textAlignment = .center
        priceLabel.font = priceLabel.font.withSize(12)
    }
    
    private func setupHierarchy() {
        addSubview(
            itemImageView,
            nameLabel,
            priceLabel
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemView {
    
    
}
