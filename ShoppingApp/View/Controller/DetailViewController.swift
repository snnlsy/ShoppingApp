//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailVM = DetailViewModel()
    private let itemKey: String

    @UsesAutoLayout
    private var itemView = ItemView()
    @UsesAutoLayout
    private var itemUpdateView = ItemUpdateView()
    @UsesAutoLayout
    private var descriptionTextView = UITextView()
    @UsesAutoLayout
    private var updateButton = UIButton()
    

    init(itemKey: String) {
        self.itemKey = itemKey
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setup() {
        detailVM.config(itemKey: itemKey)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        updateButton.setTitle(K.DetailVC.updateButtonLabel, for: .normal)
        updateButton.backgroundColor = .systemGray5
        updateButton.setTitleColor(.systemGray, for: .normal)
        updateButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        updateButton.layer.cornerRadius = 20
        updateButton.layer.masksToBounds = true
        
        descriptionTextView.isEditable = false
        descriptionTextView.textAlignment = .center
        descriptionTextView.text = detailVM.itemModel.productDescription
        
        itemView.priceLabel.text = String(detailVM.itemModel.productPrice) + K.App.currency
        itemView.itemImageView.load(from: detailVM.itemModel.productImage, raw: true)
        itemView.nameLabel.text = detailVM.itemModel.productName
        
        itemUpdateView.amountLabel.text = String(detailVM.itemCount)
        itemUpdateView.decreaseButton.addTarget(
            self, action: #selector(didTapDecreaseButton), for: .touchUpInside)
        itemUpdateView.increaseButton.addTarget(
            self, action: #selector(didTapIncreaseButton), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        view.addSubview(
            itemView,
            descriptionTextView,
            itemUpdateView,
            updateButton
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            itemView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            updateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 100),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            
            itemUpdateView.bottomAnchor.constraint(equalTo: updateButton.topAnchor),
            itemUpdateView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemUpdateView.widthAnchor.constraint(equalToConstant: 150),
            itemUpdateView.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionTextView.topAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 16),
            descriptionTextView.bottomAnchor.constraint(equalTo: itemUpdateView.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DetailViewController {
    
    @objc private func didTapUpdateButton() {
        detailVM.setCount(count: detailVM.currentCount)
    }
    
    @objc private func didTapDecreaseButton() {
        detailVM.decreaseItemCount()
        itemUpdateView.amountLabel.text = detailVM.currentCountStr
    }
    
    @objc private func didTapIncreaseButton() {
        detailVM.increaseItemCount()
        itemUpdateView.amountLabel.text = detailVM.currentCountStr
    }
}
