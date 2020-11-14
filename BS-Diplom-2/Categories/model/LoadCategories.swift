//
//  LoadCategories.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import Foundation
import Alamofire
import SVProgressHUD

class LoadCategories {
    static let shared = LoadCategories()
    
    func loadCategories(completion: @escaping(_ data: [Category]) -> ()) {
        let stringURL = "https://blackstarshop.ru/index.php?route=api/v1/categories"
        AF.request(stringURL).responseJSON { response in
            
            var categories = [Category]()
            if let data = response.value as? [String: [String: Any]] {
                for (key, category) in data {
                    if let name = category["name"] as? String,
                       let image = category["image"] as? String,
                       let iconImage = category["iconImage"] as? String,
                       let iconImageActive = category["iconImageActive"] as? String,
                       let subcategories = category["subcategories"] as? [[String: Any]] {
                        
                        if image == "" { continue }
                        
                        var subcategoryList = [Subcategory]()
                        for subcategory in subcategories {
                            var subcategoryElement = Subcategory(id: "None",
                                                                 iconImage: subcategory["iconImage"] as? String ?? "None",
                                                                 name: subcategory["name"] as? String ?? "None",
                                                                 type: subcategory["type"] as? String ?? "None")
                            if let id = subcategory["id"] as? String {
                                subcategoryElement.id = id
                            } else if let id = subcategory["id"] as? Int {
                                subcategoryElement.id = "\(id)"
                            }
                            subcategoryList.append(subcategoryElement)
                        }
                        categories.append(Category(id: key, name: name, image: image, iconImage: iconImage, iconImageActive: iconImageActive, subcategories: subcategoryList))
                    }
                }
            }
            categories.sort(by: { $0.name.lowercased() < $1.name.lowercased() })
            DispatchQueue.main.async {
                completion(categories)
            }
        }
    }
}
