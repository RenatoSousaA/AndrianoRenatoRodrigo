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
    @IBOutlet weak var lbIOF: UILabel!
    @IBOutlet weak var lbTaxas: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calcTotal()
    }
    
    func calcTotal() {
        let total: PurchaseTotal = CartsDAO.shared.getTotals(with: context)
        
        lblTotalValueInDolar.text = "\(total.totalValueInDolar)"
        lblTotalValueInBrazilianReal.text = "\(total.brlPriceTotal)"
        lbIOF.text = "\(String(format: "%.4f", total.iofTotal))"
        lbTaxas.text = "\(total.taxTotal)"
        lbTotal.text = "\(total.totalValueInBrazilianReal)"
    }

}
