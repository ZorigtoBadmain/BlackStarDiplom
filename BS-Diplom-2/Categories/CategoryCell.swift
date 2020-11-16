//
//  CategoryCell.swift
//  BS-Diplom-2
//
//  Created by Зоригто Бадмаин on 14.11.2020.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var nameCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCategory.layer.cornerRadius = imageCategory.frame.width / 2.0
        imageCategory.layer.masksToBounds = true
        imageCategory.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
