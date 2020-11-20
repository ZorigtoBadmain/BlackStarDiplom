//
//  Persistance.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 19.11.2020.
//

import Foundation
import RealmSwift

class ProductObject: Object {
//    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var colorName: String = ""
    @objc dynamic var mainImageLink: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var price: String = ""
    
    func getData(name: String, colorName: String, mainImageLink: String, size: String, price: String) {
        
        self.name = name
        self.colorName = colorName
        self.mainImageLink = mainImageLink
        self.size = size
        self.price = price
    }
}

class Persistance {
    static let shared = Persistance()
    private let realm = try! Realm()
    
    func save(item: ProductObject) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func getItems() -> Results<ProductObject> {
        realm.objects(ProductObject.self)
    }
    
    func remove(index: Int) {
        let item = realm.objects(ProductObject.self)[index]
        try! realm.write {
            realm.delete(item)
        }
    }
    
}
