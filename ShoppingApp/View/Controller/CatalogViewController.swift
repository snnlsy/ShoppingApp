//
//  CatalogViewController.swift
//  ShoppingApp
//
//  Created by Erdem Perşembe on 12.04.2022.
//

import UIKit

final class CatalogViewController: UIViewController {

    @UsesAutoLayout
    private var cartButton = UIButton()
    @UsesAutoLayout
    private var catalogCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let catalogVM = CatalogViewModel()
    private var itemList = [Int: String]()
    private var currentItemKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCartButton()
        updateCartActive()
    }

    private func setup() {
        catalogVM.delegate = self
        catalogVM.config()
    }
    
    private func setupView() {
        title = K.App.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        
        catalogCollectionView.register(CatalogCollectionViewCell.self)
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self
        
        cartButton.setTitle(catalogVM.totalCountInCart, for: .normal)
        cartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        cartButton.tintColor = .black
        cartButton.setTitleColor(.black, for: .normal)
        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
    }
    
    private func setupHierarchy() {
        view.addSubview(catalogCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            catalogCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            catalogCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            catalogCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension CatalogViewController {
    
    @objc private func didTapCartButton() {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapBuyButton(sender: UIButton) {
        if let itemName = itemList[sender.tag] {
            catalogVM.increaseItemCount(item: itemName)
            updateCartButton()
        }
    }
    
    private func updateCartButton() {
        cartButton.setTitle(catalogVM.totalCountInCart, for: .normal)
    }
}


extension CatalogViewController: CatalogViewModelProtocol {

    func reloadData() {
        catalogCollectionView.reloadDataAsync()
    }
    
    func updateCartActive() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cartButton.isUserInteractionEnabled = self.catalogVM.isCartActive
        }
    }
}


// MARK: - catalogCollectionView delegates
extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogVM.itemModelListCount
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CatalogCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let itemModel = catalogVM.itemModelList[indexPath.row]
        cell.config(itemModel: itemModel)
        currentItemKey = itemModel.productName
        itemList[indexPath.row] = itemModel.productName
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemModel = catalogVM.itemModelList[indexPath.row]
        let vc = DetailViewController(itemKey: itemModel.productName)
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - catalogCollectionView layout delegates
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width / 2.5,
            height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
