//
//  PhraseViewModel.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 21/04/26.
//

import Foundation
import Combine

/// @MainActor - Todo este ViewModel se ejecuta en el Main Thread (UI thread)
@MainActor
class PhraseViewModel : ObservableObject {
    @Published var phrases : [Phrase] = []
    @Published var randomPhrases : [Phrase] = []
    @Published var isLoading = false
    
    private let repository: PhraseRepository
    
    init(repository: PhraseRepository) {
        self.repository = repository
    }
    
    func loadPhrases() {
        /// Haz esto en segundo plano
        Task {
            do {
                isLoading = true
                
                /// try se usa cuando la función puede lanzar error (throws)
                /// await se usa para esperar una función async
                /// •    Suspende ejecución
                /// •    Espera resultado
                /// •    Continúa después
                phrases = try await repository.fetchPhrases()
                phrases = phrases.shuffled()
                
                isLoading = false
            } catch {
                print(error)
                isLoading = false
            }
        }
    }
    
    /// Cuando llames esta función, no escribas el nombre item
    ///     func moveToBack(_ item: Phrase) {
    func moveToBack() {
        /// elimina el ultimo valor y lo guarda en top (la card que se encuentra mas arriba)
        ///     let top = phrases[phrases.count - 1] // obtener último
        ///     phrases.removeLast()                 // quitarlo
        ///     phrases.insert(top, at: 0)           // ponerlo adelante (al final)
        let top = phrases.removeLast()
        
        /// coloca top en la ultima posicion
        phrases.insert(top, at: 0)
    }
}


/*
     func loadPhrases() async {
         do {
             isLoading = true
             phrases = try await repository.fetchPhrases()
             isLoading = false
         } catch {
             print(error)
             isLoading = false
         }
     }
     
     Task {
         await viewModel.loadPhrases()
     }
 */
