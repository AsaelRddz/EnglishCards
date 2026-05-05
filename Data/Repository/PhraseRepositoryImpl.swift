//
//  Untitled.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 20/04/26.
//

import CoreData

class PhraseRepositoryImpl: PhraseRepository {
    private let remote: PhraseRemoteDataSource
    
    /// contexto para core data
    private let context: NSManagedObjectContext
    
    init(remoteDataSource: PhraseRemoteDataSource, context : NSManagedObjectContext) {
        self.remote = remoteDataSource
        self.context = context
    }
    
    func sync() async throws {
        /// obtiene datos de la api 
        let dtos = try await remote.fetchPhrases()
        
        for dto in dtos {
            
            /// preparas query
            let request: NSFetchRequest<PhraseEntity> = PhraseEntity.fetchRequest()
            
            /// filtro: busca registros con mismo id
            request.predicate = NSPredicate(format: "id == %d", dto.id)
            
            /// si existe → lo obtienes ------- si no → nil
            let existing = try context.fetch(request).first
            
            if let existing {
                // update item
                existing.text = dto.text
                existing.example = dto.example
                existing.descriptionText = dto.description
            } else {
                // insert new item
                let new = PhraseEntity(context: context)
                new.id = Int64(dto.id)
                new.text = dto.text
                new.example = dto.example
                new.descriptionText = dto.description
                new.favorite = false
            }
        }
        try context.save()
        print("✅ Sync completo")
    }
}
