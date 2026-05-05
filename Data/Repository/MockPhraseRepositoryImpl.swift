//
//  MockPhraseRepositoryImpl.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 22/04/26.
//

import Foundation
import CoreData

class MockPhraseRepositoryImpl : PhraseRepository {
    private let context : NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func sync() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let mockData = [
            PhraseDTO(id: 1, text: "Hello world", example: "First program", description: "basic"),
            PhraseDTO(id: 2, text: "How are you?", example: "Daily question", description: "common"),
            PhraseDTO(id: 3, text: "SwiftUI Preview", example: "UI testing", description: "dev"),
            PhraseDTO(id: 4, text: "Mock phrase", example: "Sample data", description: "test")
        ]
        
        for dto in mockData {
            let request : NSFetchRequest<PhraseEntity> = PhraseEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", dto.id)
            
            let existing = try context.fetch(request).first
            
            if let existing {
                existing.text = dto.text
                existing.example = dto.example
                existing.descriptionText = dto.description
            } else {
                let new = PhraseEntity(context: context)
                new.id = Int64(dto.id)
                new.text = dto.text
                new.example = dto.example
                new.descriptionText = dto.description
                new.favorite = false
            }
        }
        try context.save()
        print("🧪 Mock sync completo")
    }
}
