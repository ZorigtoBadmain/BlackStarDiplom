//
//  RealmDataBase.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 18.11.2020.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var quantity = String()
    @objc dynamic var image = ""
    @objc dynamic var nameProduct = ""
    @objc dynamic var sizeProduct = ""
    @objc dynamic var colorProduct = ""
    @objc dynamic var priceProduct = ""
    @objc dynamic var productOfferID = String()
}

class RealmDataBase {
    static let shared = RealmDataBase()
    var product = ProductList()
    var productList: [ProductList] = []
    
    let realm = try! Realm()
    
    func setProduct(product: ProductList) {
        self.product = product
      
    }
    
    func recordProduct() {
        try! realm.write {
            let currentProduct = Product()
            
            currentProduct.image = product.mainImage
            currentProduct.nameProduct = product.name
            currentProduct.sizeProduct = product.offers[0].size
            currentProduct.colorProduct = product.colorName
            currentProduct.priceProduct = product.price
            
            realm.add(currentProduct)
        }
    }
    
    func getSaveProduct() -> [ProductList] {
        productList = []
        
        for prod in realm.objects(Product.self) {
            productList.append(ProductList(quantity: prod.quantity,
                                           titleLabel: prod.nameProduct,
                                           sizeLabel: prod.sizeProduct,
                                           colorLabel: prod.colorProduct,
                                           priceLabel: prod.priceProduct,
                                           productOfferID: prod.productOfferID,
                                           image: prod.image))
        }
        
        return productList
    }
    
    func deleteAllProduct() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteProduct(id: String) {
        for prod in realm.objects(Product.self) {
            if id == prod.productOfferID {
                try! realm.write {
                    realm.delete(prod)
                }
                break
            }
        }
        productList = []
    }
}
