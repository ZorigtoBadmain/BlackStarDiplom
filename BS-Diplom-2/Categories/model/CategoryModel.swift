//
//  CategoryModel.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import Foundation

struct Category {

    let name: String
    let sortOrder: String
    let image:String
    let iconImage: String
    let iconImageActive: String
    var subcategories: [Subcategory]
    
    init?(dict: NSDictionary) {
        guard let name = dict["name"] as? String,
              let sortOrder = dict["sortOrder"] as? String,
              let image = dict["image"] as? String,
              let iconImage = dict["iconImage"] as? String,
              let iconImageActive = dict["iconImageActive"] as? String,
              let subcategories = dict["subcategories"] as? [NSDictionary] else { return nil }
        
        var subcategoryList = [Subcategory]()
        for subcategory in subcategories {
            if let subcategoryItem = Subcategory(dict: subcategory) {
                subcategoryList.append(subcategoryItem)
            }
        }
        
        self.name = name
        self.sortOrder = sortOrder
        self.image = image
        self.iconImage = iconImage
        self.iconImageActive = iconImageActive
        self.subcategories = subcategoryList
    }
}

struct Subcategory {
    let id: String
    let iconImage: String
    let sortOrder: String
    let name: String
    let type: String
    
    init?(dict: NSDictionary) {
        guard let id = dict["id"] as? String,
              let iconImage = dict["iconImage"] as? String,
              let sortOrder = dict["sortOrder"] as? String,
              let name = dict["name"] as? String,
              let type = dict["type"] as? String else { return nil }
        
        self.id = id
        self.iconImage = iconImage
        self.sortOrder = sortOrder
        self.name = name
        self.type = type
    }
}
