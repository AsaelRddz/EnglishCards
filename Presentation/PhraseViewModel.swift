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
    @Published var isLoading = false
    @Published var randomPhrase: String = ""
    
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
                self.setRandomPhrase()
                
                isLoading = false
            } catch {
                print(error)
                isLoading = false
            }
        }
    }
    
    func setRandomPhrase() {
        randomPhrase = phrases.randomElement()?.text ?? ""
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
