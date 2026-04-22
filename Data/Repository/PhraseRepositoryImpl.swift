//
//  Untitled.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 20/04/26.
//

class PhraseRepositoryImpl : PhraseRepository {
    private let remoteDataSource : PhraseRemoteDataSource
    
    init(remoteDataSource : PhraseRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchPhrases() async throws -> [Phrase] {
        try await remoteDataSource.fetchPhrases()
    }
}
