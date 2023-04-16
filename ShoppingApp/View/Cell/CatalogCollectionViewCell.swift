//
//  CatalogCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 27.03.2023.
//

import UIKit

final class CatalogCollectionViewCell: UICollectionViewCell {
    
    @UsesAutoLayout
    private var itemView = ItemView()
    @UsesAutoLayout
    var buyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupView() {
        buyButton.backgroundColor = .systemGray4
        buyButton.setTitle(K.CatalogTVC.buyButtonLabel, for: .normal)
        buyButton.setTitleColor(.systemGray, for: .normal)
        buyButton.layer.cornerRadius = 10
        buyButton.layer.masksToBounds = true
    }
    
    private func setupHierarchy() {
        contentView.addSubview(
            itemView,
            buyButton
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: topAnchor),
            itemView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -8),
            itemView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 30),
            buyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            buyButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CatalogCollectionViewCell {
    
    func config(itemModel: ItemModel) {
        itemView.itemImageView.load(from: itemModel.productImage, raw: true)
        itemView.nameLabel.text = itemModel.productName
        itemView.priceLabel.text = String(itemModel.productPrice) + K.App.currency
    }
}

