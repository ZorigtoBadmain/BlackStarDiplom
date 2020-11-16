//
//  LoadCategories.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import Foundation
import Alamofire
import SVProgressHUD

class CategoriesLoader {
    static let shared = CategoriesLoader()
    
    func loadCategories(completion: @escaping(_ data: [Category]) -> ()) {
//        SVProgressHUD.show()
        let stringURL = "https://blackstarshop.ru/index.php?route=api/v1/categories"
        AF.request(stringURL).responseJSON { response in
            
            if let objects = response.value,
               let jsonDict = objects as? NSDictionary {
                
                DispatchQueue.main.async {
                    var categories: [Category] = []
                    print(jsonDict)
                    
                    for (_, data) in jsonDict where data is NSDictionary {
                        if let category = Category(dict: data as! NSDictionary) {
                            if !category.image.isEmpty {
                                categories.append(category)
                            }
                            
                        }
                    }
                    
                    completion(categories)
//                    SVProgressHUD.dismiss()
                
                }
            }
        }
    }
}
