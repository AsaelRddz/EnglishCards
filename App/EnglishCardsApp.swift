//
//  EnglishCardsApp.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

import SwiftUI

/** (y luego al reves)
 SwiftUI View
      ↓
 ViewModel
      ↓
 Repository (Protocol - Domain)
      ↓
 RepositoryImpl (Data)
      ↓
 RemoteDataSource
      ↓
 ApiClient
      ↓
 API / Firebase
 **/

@main
/// App --- AppDelegate
struct EnglishCardsApp: App {
    
    var body: some Scene {
        WindowGroup {
            /// Quien prepara datos para la UI
            let viewModel = PhraseViewModel(repository: repository)
            
            /// Muestras la pantalla
            PhraseListView(viewModel: viewModel)
        }
    }
    
    /// Quien organiza los datos
    private var repository: PhraseRepository {
        switch AppConfig.environment {
        case .mock:
            return MockPhraseRepositoryImpl()
            
        case .production:
            /// Quien habla con internet
            let apiClient = ApiClient()
            /// Quien pide datos al API
            let remote = PhraseRemoteDataSource(apiClient: apiClient)
            
            return PhraseRepositoryImpl(remoteDataSource: remote)
        }
    }
}
