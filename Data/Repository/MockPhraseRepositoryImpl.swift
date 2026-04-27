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
            Phrase(
                id: 1,
                text: "Hello world",
                example: "Hello world is usually the first program."
            ),
            Phrase(
                id: 2,
                text: "How are you?",
                example: "How are you doing today?"
            ),
            Phrase(
                id: 3,
                text: "SwiftUI Preview",
                example: "SwiftUI Preview helps visualize views quickly."
            ),
            Phrase(
                id: 4,
                text: "This is a mock phrase",
                example: "This is only sample data for testing."
            )
        ]
    }
}
