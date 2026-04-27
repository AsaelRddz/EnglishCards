//
//  PhraseRemoteDataSource.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 20/04/26.
//

import Foundation


// Data -> Domain
class PhraseRemoteDataSource {
    private let apiClient : ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchPhrases() async throws -> [Phrase] {
        guard let url = URL(string: "https://englishcards-fs001-default-rtdb.firebaseio.com/.json") else { return [] }
        
        let response : [PhraseDTO] = try await apiClient.request(url: url)
        
        print(response)
        
        /// .map transforma cada elemento de una colección y devuelve una nueva colección transformada.
        return response.map { value in
            Phrase(
                id: value.id, text: value.text, example: value.example
            )
        }
    }
}
