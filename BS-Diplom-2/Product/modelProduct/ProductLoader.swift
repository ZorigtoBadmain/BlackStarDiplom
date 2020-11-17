//
//  File.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 17.11.2020.
//

import Foundation
import Alamofire

class ProductLoader {
    static let shared = ProductLoader()
    
    func loadProduct(item: String, completion: @escaping ([ProductList]) -> Void){
        
        let stringUrl = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=\(item)"
        
        AF.request(stringUrl).responseJSON { (response) in
            if let object = response.value,
               let jsonDict = object as? NSDictionary {
                
                DispatchQueue.main.async {
                    var products: [ProductList] = []
                    
                    for (_, data) in jsonDict where data is NSDictionary {
                        if let product = ProductList(dict: data as! NSDictionary) {
                            products.append(product)
                        }
                    }
                    
                    completion(products)
                }
            }
        }
    }
}
