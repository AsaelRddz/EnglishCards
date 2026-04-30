//
//  EnglishCardsApp.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

import SwiftUI
import CoreData

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
        let persistence = PersistenceController.shared
        
        WindowGroup {
            /// Quien prepara datos para la UI
            let viewModel = PhraseViewModel(repository: repository)
            
            /// Muestras la pantalla
            PhraseHomeView(viewModel: viewModel)
                /// Inyecta el contexto de Core Data al árbol de vistas.
                /// Ya no tienes que pasar "context" manualmente por parámetros.
                /// Todas las vistas hijas pueden acceder a él con:
                    /// @Environment(\.managedObjectContext)
                    /// private var context
                .environment(\.managedObjectContext, persistence.container.viewContext)
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
