//
//  CartsManager.swift
//  AndrianoRenatoRodrigo
//
//  Created by Adriano on 3/18/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import CoreData

class CartsDAO {
    
    private init() {
    }
    
    static let shared = CartsDAO()
   
    func getTotals (with context: NSManagedObjectContext) -> PurchaseTotal {
        
        let config = Configuration.shared
        var totalValueInDolar: Double = 0.0
        
        var iofTotal: Double = 0.0
        var taxTotal: Double = 0.0
        var brlPriceTotal: Double = 0.0
        var totalValueInBrazilianReal: Double = 0.0
        
        StatesDAO.shared.loadStates(with: context)
        for state in StatesDAO.shared.states {
            if let carts = state.carts?.allObjects as? [Cart] {
            for cart in carts{
                
                let iof = cart.priceRS * config.iof / 100
                iofTotal += iof
                
                if (cart.isCard) {
                    taxTotal += state.tax
                }
                
                brlPriceTotal += cart.price * config.dolar
                
                totalValueInDolar += cart.price
                totalValueInBrazilianReal += (state.tax + iof + brlPriceTotal)
            }
            } else {}
        }
        
        return PurchaseTotal(totalValueInDolar:totalValueInDolar,  totalValueInBrazilianReal :totalValueInBrazilianReal, iofTotal: iofTotal, taxTotal: taxTotal, brlPriceTotal: brlPriceTotal )
    }
    
}
