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
        /// Crea el contenedor principal de Core Data.
        container = NSPersistentContainer(name: "EnglishCardsModel")
        
        /// Carga la base de datos (SQLite por debajo)
        container.loadPersistentStores { _, error in
            
            /// Si no carga la base local, detenemos la app
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        
        /// Si hay cambios desde otro contexto/background
            /// se mezclan automáticamente en el contexto principal.
            /// útil para sync/offline-first
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
