//
//  StatesManager.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 25/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import CoreData

class StatesManager {
    static let shared = StatesManager()
    var states: [States] = []
    
    func loadStates(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<States> = States.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            states = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteState(index: Int, context: NSManagedObjectContext) {
        let state = states[index]
        context.delete(state)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        
    }
}
