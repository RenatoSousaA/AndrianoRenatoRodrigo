//
//  ViewControllet+CoreData.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 24/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
