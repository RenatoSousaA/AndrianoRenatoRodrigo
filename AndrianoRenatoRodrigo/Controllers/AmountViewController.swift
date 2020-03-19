//
//  AmountViewController.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 24/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {

    @IBOutlet weak var lblTotalValueInBrazilianReal: UILabel!
    @IBOutlet weak var lblTotalValueInDolar: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let total: PurchaseTotal = CartsDAO.shared.getTotals(with: context)
        lblTotalValueInBrazilianReal.text = "Price total: \(total.brlPriceTotal)\nIOF: \(String(format: "%.4f", total.iofTotal))\nTaxes: \(total.taxTotal)\nTotal: \(total.totalValueInBrazilianReal)"
        lblTotalValueInDolar.text = "\(total.totalValueInDolar)"
    }

}
