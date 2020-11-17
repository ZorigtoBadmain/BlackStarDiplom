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
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    
    private let activity = UIActivityIndicatorView()
    private var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var subcategories: [Subcategory] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tableIndex = 0
    var categoryId = ""
    
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
        
        backButtonItem.isEnabled = false
        backButtonItem.tintColor = .clear
    }
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        tableIndex = 0
        backButtonItem.isEnabled = false
        backButtonItem.tintColor = .clear
        tableView.reloadData()
    }
    
    func setupActivity(){
        activity.center = view.center
        activity.hidesWhenStopped = true
        activity.style = .large
        view.addSubview(activity)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableIndex == 0 {
            return categories.count
        } else {
            return subcategories.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        if tableIndex == 0 {
            navigationItem.title = "Каталог"
            let cat = categories[indexPath.row]
            cell.nameCategory.text = cat.name
            let url = URL(string: "https://blackstarwear.ru/\(cat.image)")
            cell.imageCategory.sd_setImage(with: url)
            
            return cell
        } else {
            let cat = subcategories[indexPath.row]
            cell.nameCategory.text = cat.name
            let url = URL(string: "https://blackstarwear.ru/\(cat.iconImage)")
            cell.imageCategory.sd_setImage(with: url)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableIndex == 0 {
            tableIndex = 1
            subcategories = categories[indexPath.row].subcategories
            navigationItem.title = categories[indexPath.row].name
            backButtonItem.isEnabled = true
            backButtonItem.tintColor = .blue
        } else if tableIndex == 1 {
            tableIndex = 0
            let product = subcategories[indexPath.row]
            self.categoryId = product.id
            self.performSegue(withIdentifier: "productList", sender: categoryId)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "productList",
           let destination = segue.destination as? ProductCollectionVC,
           let id = sender as? String {
            destination.category_Id = id
            tableIndex = 1
        }
    }
}
