//
//  CategoryModel.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import Foundation

struct Category {
    var id: String
    var name: String
    var image:String
    var iconImage: String
    var iconImageActive: String
    var subcategories: [Subcategory]
}

struct Subcategory {
    var id: String
    var iconImage: String
    var name: String
    var type: String
}
