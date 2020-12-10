//
//  BasketVC.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 19.11.2020.
//

import UIKit
import SDWebImage

class BasketVC: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var senderOrderButton: UIButton!
    @IBOutlet weak var shopingTableView: UITableView!
    
    var items = Persistance.shared.getItems() {
        didSet {
            shopingTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shopingTableView.reloadData()
        summaProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(items)
        shopingTableView.delegate = self
        shopingTableView.dataSource = self
        
      summaProducts()
    }
    
    func summaProducts() {
        var summa = 0
        for item in items {
            summa += Int(Double(item.price) ?? 0)
        }
        priceLabel.text = "\(summa) руб"
    }
}

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        
        let productItem = items[indexPath.row]
        cell.colorProduct.text = productItem.colorName
        cell.sizeProduct.text = productItem.size
        cell.nameProduct.text = productItem.name
        cell.priceProduct.text = "\(Int(Double(productItem.price) ?? 0)) руб."
        let url = URL(string: "https://blackstarshop.ru/\(productItem.mainImageLink)")

        cell.imageProduct.sd_setImage(with: url, completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
      
            Persistance.shared.remove(index: indexPath.row)
            summaProducts()
            tableView.reloadData()
        }
    }
}
