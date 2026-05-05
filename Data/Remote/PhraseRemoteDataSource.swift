//
//  PhraseRemoteDataSource.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 20/04/26.
//

import Foundation

class PhraseRemoteDataSource {
    private let apiClient : ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func fetchPhrases() async throws -> [PhraseDTO] {
        guard let url = URL(string: "https://englishcards-fs001-default-rtdb.firebaseio.com/.json") else { return [] }
        
        let response : [PhraseDTO] = try await apiClient.request(url: url)
        
        print(response)
        
        return response
    }
}
