//
//  ProductCardVC.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 18.11.2020.
//

import UIKit

class ProductCardVC: UIViewController {

    @IBOutlet weak var productImagePageControl: UIPageControl!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageProductCollection: UICollectionView!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var addToCard: UIButton!
    
    var product = ProductList()
    var itemCard: [ProductList] = []
    var dataImages = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addToCard.layer.cornerRadius = 10
        
        addDateInUI()
        
        imageProductCollection.dataSource = self
        imageProductCollection.delegate = self
        
        for imageURL in product.productImages {
            if let url = URL(string: "https://blackstarshop.ru/\(imageURL)") {
                do {
                    let data = try Data(contentsOf: url)
                    dataImages.append(data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func addDateInUI() {
        let priceFormatted = Int(Double(product.price)!)
        priceLabel.text = "\(priceFormatted) руб."
        nameProductLabel.text = product.name
        descriptionProduct.text = product.description
    }
    
    @IBAction func addToCardAction(_ sender: UIButton) {
        
    }
    

}

extension ProductCardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productImagePageControl.numberOfPages = dataImages.count
        return dataImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductImageCell
        let page = Int(imageProductCollection.contentOffset.x/UIScreen.main.bounds.width)
        productImagePageControl.currentPage = page
        cell.imageProduct.image = UIImage(data: dataImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: imageProductCollection.frame.height)
    }
    
    
}
