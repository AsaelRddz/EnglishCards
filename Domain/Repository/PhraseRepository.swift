//
//  PhraseRepository.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

/*protocol PhraseRepository {
    func fetchPhrases() async throws -> [Phrase]
}*/

///ANTES:
///Repository devuelve datos

///AHORA:
///Repository sincroniza datos: escribe en Core Data

protocol PhraseRepository {
    func sync() async throws
}
