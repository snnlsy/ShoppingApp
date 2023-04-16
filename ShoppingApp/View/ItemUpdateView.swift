//
//  ItemUpdateView.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 30.03.2023.
//

import UIKit

final class ItemUpdateView: UIView {
    
    @UsesAutoLayout
    var decreaseButton = UIButton()
    @UsesAutoLayout
    var increaseButton = UIButton()
    @UsesAutoLayout
    var amountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupView() {
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.backgroundColor = .systemGray5
        decreaseButton.setTitleColor(.systemGray, for: .normal)
        decreaseButton.layer.cornerRadius = 20
        decreaseButton.layer.masksToBounds = true
        
        increaseButton.setTitle("+", for: .normal)
        increaseButton.backgroundColor = .systemGray5
        increaseButton.setTitleColor(.systemGray, for: .normal)
        increaseButton.layer.cornerRadius = 20
        increaseButton.layer.masksToBounds = true
        
        amountLabel.textAlignment = .center
    }
    
    private func setupHierarchy() {
        addSubview(
            decreaseButton,
            amountLabel,
            increaseButton
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            decreaseButton.topAnchor.constraint(equalTo: topAnchor),
            decreaseButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            decreaseButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            decreaseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            
            amountLabel.topAnchor.constraint(equalTo: topAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: decreaseButton.trailingAnchor),
            amountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
           
            increaseButton.topAnchor.constraint(equalTo: topAnchor),
            increaseButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            increaseButton.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor),
            increaseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
