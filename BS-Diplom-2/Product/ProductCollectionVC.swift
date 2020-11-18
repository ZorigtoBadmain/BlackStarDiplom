//
//  ProductCollectionVC.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 17.11.2020.
//

import UIKit

class ProductCollectionVC: UICollectionViewController {
    
    var category_Id: String = ""
    var product: [ProductList] = []
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductLoader.shared.loadProduct(item: category_Id) { (data) in
            self.product = data
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return product.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        let prod = product[indexPath.row]
        cell.setupCell(product: prod)
        cell.loadImageIndicator.startAnimating()
        if let url = URL(string: "https://blackstarshop.ru/\(prod.mainImage)") {
            cell.productImage.sd_setImage(with: url)
            cell.loadImageIndicator.stopAnimating()
        }
  
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = collectionView.bounds.width
        return CGSize(width: h, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        self.performSegue(withIdentifier: "ProductCard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ProductCard" else { return }
        guard let destination = segue.destination as? ProductCardVC else { return }
        let productSelect = product[self.index]
        destination.product = productSelect
        destination.itemCard = product
    }
}
