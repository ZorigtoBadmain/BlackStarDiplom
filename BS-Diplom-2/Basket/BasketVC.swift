//
//  BasketVC.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 19.11.2020.
//

import UIKit

class BasketVC: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var senderOrderButton: UIButton!
    @IBOutlet weak var shopingTableView: UITableView!
    
    var items = Persistance.shared.getItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shopingTableView.delegate = self
        shopingTableView.dataSource = self
        
        
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
        cell.priceProduct.text = productItem.price
        
        return cell
    }
    
    
}
