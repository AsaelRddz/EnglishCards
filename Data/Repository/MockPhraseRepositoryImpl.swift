//
//  MockPhraseRepositoryImpl.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 22/04/26.
//

import Foundation

class MockPhraseRepositoryImpl : PhraseRepository {    
    func fetchPhrases() async throws -> [Phrase] {
        try await Task.sleep(nanoseconds: 2_000_000_000)

        return [
            Phrase(id: 1, text: "Hello world"),
            Phrase(id: 2, text: "How are you?"),
            Phrase(id: 3, text: "SwiftUI Preview"),
            Phrase(id: 4, text: "This is a mock phrase")
        ]
    }
}
