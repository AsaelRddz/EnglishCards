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
            /// Quien habla con internet
            let apiClient = ApiClient()
            
            /// Quien pide datos al API
            let remote = PhraseRemoteDataSource(apiClient: apiClient)
            
            /// Quien organiza los datos
            let repository = PhraseRepositoryImpl(remoteDataSource: remote)
            
            /// Quien prepara datos para la UI
            let viewModel = PhraseViewModel(repository: repository)
            
            /// Muestras la pantalla
            PhraseListView(viewModel: viewModel)
        }
    }
}
 



/*
 @main
 struct EnglishCardsApp: App {
     
     var body: some Scene {
         WindowGroup {
             
             let apiClient = ApiClient()
             let remote = PhraseRemoteDataSource(apiClient: apiClient)
             let repository = PhraseRepositoryImpl(remoteDataSource: remote)
             let viewModel = PhraseViewModel(repository: repository)
             
             PhraseListView(viewModel: viewModel)
         }
     }
 }
 */
