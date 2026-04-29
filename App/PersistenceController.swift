//
//  PersistenceController.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 28/04/26.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "EnglishCardsModel")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
