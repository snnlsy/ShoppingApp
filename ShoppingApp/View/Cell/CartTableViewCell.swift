//
//  CartTableViewCell.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    
    private var itemModel: ItemModel!
    @UsesAutoLayout
    private var itemView = ItemView()
    @UsesAutoLayout
    private var itemUpdateView = ItemUpdateView()
    
    var decreaseButtonHandler: ((String) -> ())?
    var increaseButtonHandler: ((String) -> ())?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupView() {
        itemUpdateView.decreaseButton.addTarget(self, action: #selector(didTapDecreaseButton), for: .touchDown)
        itemUpdateView.increaseButton.addTarget(self, action: #selector(didTapIncreaseButton), for: .touchDown)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(
            itemView,
            itemUpdateView
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: topAnchor),
            itemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            itemUpdateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemUpdateView.widthAnchor.constraint(equalToConstant: 150),
            itemUpdateView.heightAnchor.constraint(equalToConstant: 40),
            itemUpdateView.leadingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: 16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CartTableViewCell {
    
    func config(itemModel: ItemModel, itemCount: Int) {
        self.itemModel = itemModel
        itemView.nameLabel.text = itemModel.productName
        itemView.priceLabel.text = String(itemModel.productPrice) + K.App.currency
        itemView.itemImageView.load(from: itemModel.productImage, raw: true)
        itemUpdateView.amountLabel.text = String(itemCount)
    }
}


extension CartTableViewCell {
    
    @objc private func didTapDecreaseButton() {
        guard let amountText = itemUpdateView.amountLabel.text,
              var amount = Int(amountText) else { return }
        amount -= 1
        let amountStr = String(amount)
        itemUpdateView.amountLabel.text = amountStr
        decreaseButtonHandler?(itemModel.productName)
    }
    
    @objc private func didTapIncreaseButton() {
        guard let amountText = itemUpdateView.amountLabel.text,
              var amount = Int(amountText) else { return }
        amount += 1
        let amountStr = String(amount)
        itemUpdateView.amountLabel.text = amountStr
        increaseButtonHandler?(itemModel.productName)
    }
}
