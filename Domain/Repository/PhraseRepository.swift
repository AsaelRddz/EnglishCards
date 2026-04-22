//
//  PhraseRepository.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

protocol PhraseRepository {
    func fetchPhrases() async throws -> [Phrase]
}
