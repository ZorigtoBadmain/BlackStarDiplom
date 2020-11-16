//
//  CategoriesTVC.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import UIKit
import SDWebImage
import SVProgressHUD

class CategoriesTVC: UITableViewController {
    
    private let activity = UIActivityIndicatorView()
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivity()
        activity.startAnimating()
//        SVProgressHUD.show()

        CategoriesLoader.shared.loadCategories { data in
            
            self.categories = data
            self.tableView.reloadData()
            self.activity.stopAnimating()
//            SVProgressHUD.dismiss()

        }
    }
    
    func setupActivity(){
        activity.center = view.center
        activity.hidesWhenStopped = true
        activity.style = .large
        view.addSubview(activity)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

        let cat = categories[indexPath.row]
        cell.nameCategory.text = cat.name
        let url = URL(string: "https://blackstarwear.ru/\(cat.image)")
        cell.imageCategory.sd_setImage(with: url)

        return cell
    }
}
