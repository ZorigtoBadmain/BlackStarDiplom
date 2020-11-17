//
//  Product.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 17.11.2020.
//

import Foundation

struct ProductList {
    let name: String
    let description: String
    let mainImage: String
    let price: String
    let colorName: String
    let colorImageURL: String
    var productImages: [String] = []
    var offers: [Offers] = []
    var isEmpty = true
    
    init?(dict: NSDictionary) {
        guard let name = dict["name"] as? String,
              let description = dict["description"] as? String,
              let mainImage = dict["mainImage"] as? String,
              let price = dict["price"] as? String,
              let colorName = dict["colorName"] as? String,
              let colorImageURL = dict["colorImageURL"] as? String,
              let offers = dict["offers"] as? NSArray,
              offers.count != 0 else { return nil }
        
        for image in dict["productImages"] as! NSArray {
            if let productImage = image as? NSDictionary {
                productImages.append(productImage["imageURL"] as! String)
            }
        }
        
        for subdata in dict["offers"] as! NSArray {
            if let offer = Offers(dict: subdata as! NSDictionary) {
                self.offers.append(offer)
            }
        }
        
        self.name = name
        self.description = description
        self.mainImage = mainImage
        self.price = price
        self.colorName = colorName
        self.colorImageURL = colorImageURL
    }
    
    init() {
        self.name = ""
        self.description = ""
        self.mainImage = ""
        self.price = ""
        self.colorName = ""
        self.colorImageURL = ""
    }
    
    init(quantity: String,
         titleLabel: String,
         sizeLabel: String,
         colorLabel: String,
         priceLabel: String,
         productOfferID: String,
         image: String) {
        
        self.offers = [Offers(size: sizeLabel, productOfferID: productOfferID, quantity: quantity)]
        
        self.description = ""
        self.colorImageURL = ""
        self.name = titleLabel
        self.mainImage = image
        self.colorName = colorLabel
        self.price = priceLabel
        self.isEmpty = false
        
        
    }
    
    struct Offers {
        let size: String
        let productOfferID: String
        let quantity: String
        
        init?(dict: NSDictionary) {
            guard let size = dict["size"] as? String,
                  let productOfferID = dict["productOfferID"] as? String,
                  let quantity = dict["quantity"] as? String else { return nil }
            
            self.size = size
            self.productOfferID = productOfferID
            self.quantity = quantity
        }
        
        init() {
            self.size = ""
            self.productOfferID = ""
            self.quantity = ""
        }
        
        init(size: String, productOfferID: String, quantity: String) {
            self.size = size
            self.productOfferID = productOfferID
            self.quantity = quantity
        }
    }
}
