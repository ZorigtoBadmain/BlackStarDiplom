//
//  ProductCollectionViewCell.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 17.11.2020.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var buttonBay: UIButton!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var loadImageIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        buttonBay.layer.cornerRadius = 5
    }
    
    func setupCell(product: ProductList) {
        descriptionProduct.text = product.name
        let priceFormat = Int(Double(product.price)!)
        priceProduct.text = "\(priceFormat) руб."
    }
}
