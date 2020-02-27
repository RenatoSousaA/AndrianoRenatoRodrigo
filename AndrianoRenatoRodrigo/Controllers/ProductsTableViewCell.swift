//
//  ProductsTableViewCell.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 24/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with product: Cart) {
        lbName.text = product.name
        lbPrice.text = "U$ \(product.price)"
        
        if let image = product.imgProduct as? UIImage {
            ivProduct.image = image
        } else {
            ivProduct.image = UIImage(named: "imgProdutos")
        }
    }

}
