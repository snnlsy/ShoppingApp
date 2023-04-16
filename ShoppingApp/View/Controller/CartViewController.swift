//
//  CartViewController.swift
//  ShoppingApp
//
//  Created by Sinan Ulusoy on 28.03.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let cartVM = CartViewModel()
    @UsesAutoLayout
    private var cartTableView = UITableView()
    @UsesAutoLayout
    private var checkoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func setup() {
        cartVM.delegate = self
        cartVM.config()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        cartTableView.register(CartTableViewCell.self)
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.isUserInteractionEnabled = true
        cartTableView.allowsSelection = false
        
        checkoutButton.backgroundColor = .systemGray5
        checkoutButton.setTitleColor(.systemGray, for: .normal)
        checkoutButton.addTarget(self, action: #selector(showCheckoutAlert), for: .touchUpInside)
        checkoutButton.layer.cornerRadius = 20
        checkoutButton.layer.masksToBounds = true
        checkoutButton.setTitle(
            K.CartVC.checkoutButtonLabel + cartVM.totalPrice + K.App.currency, for: .normal)
    }
    
    private func setupHierarchy() {
        view.addSubview(cartTableView, checkoutButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.widthAnchor.constraint(equalToConstant: 200),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -16),
            cartTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cartTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}


extension CartViewController {
    
    @objc private func showCheckoutAlert(_ sender: UIButton) {
        
        self.showToast(message: cartVM.totalPrice + K.CartVC.checkotMessage)
        cartVM.removeAllInCart()
    }
}


extension CartViewController: CartViewModelProtocol {
    
    func reloadData() {
        cartTableView.reloadDataAsync()
    }

    func setTotalPrice(_ totalPrice: String) {
        checkoutButton.setTitle(K.CartVC.checkoutButtonLabel + totalPrice, for: .normal)
    }
}


extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartVM.itemsInCartCount
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let itemModel = cartVM.getItemsInCart()[indexPath.row]
        let itemCount = cartVM.getItemCount(itemModel: itemModel)
        cell.config(itemModel: itemModel, itemCount: itemCount)
        cell.decreaseButtonHandler = { [weak self] itemName in
            self?.cartVM.decreaseItem(itemName: itemName)
        }
        cell.increaseButtonHandler = { [weak self] itemName in
            self?.cartVM.increaseItem(itemName: itemName)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
