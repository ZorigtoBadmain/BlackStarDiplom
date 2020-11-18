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
    var tableViewSizeAndColor = UITableView(frame: CGRect(x: 5, y: 50, width: 365, height: 170))
    var selectRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addToCard.layer.cornerRadius = 10
        
        addDateInUI()
        
        imageProductCollection.dataSource = self
        imageProductCollection.delegate = self
        
        tableViewSizeAndColor.dataSource = self
        tableViewSizeAndColor.delegate = self
        
        tableViewSizeAndColor.register(UINib(nibName: "SizeColorCell", bundle: nil), forCellReuseIdentifier: "SizeColorCell")
        
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
        let alert = UIAlertController(title: "Выберите размер", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.view.addSubview(tableViewSizeAndColor)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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

extension ProductCardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SizeColorCell", for: indexPath) as! SizeColorCell
        cell.colorName.text = product.colorName
        cell.sizeName.text = product.offers[indexPath.row].size
        if indexPath.row == selectRow {
            cell.check.isHidden = false
        } else {
            cell.check.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewSizeAndColor.deselectRow(at: indexPath, animated: true)
        selectRow = indexPath.row
        tableViewSizeAndColor.reloadData()
    }
}
