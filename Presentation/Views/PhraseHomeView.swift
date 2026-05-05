//
//  PhraseHomeView.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 21/04/26.
//

import Foundation
import SwiftUI
import Combine
import CoreData

struct PhraseHomeView : View {
    
    @StateObject private var viewModel: PhraseViewModel
    
    @Environment(\.managedObjectContext)
    private var context
    
    init(viewModel: PhraseViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ZStack {
                    ZStack {
                        /// Por eso se coloca -- id: \.id
                        /// id: 1 → DraggableCard → offset propio
                        /// id: 2 → DraggableCard → offset propio
                        /// id: 3 → DraggableCard → offset propio
                        //ForEach(viewModel.randomPhrases, id: \.id) { item in
                        ForEach(viewModel.randomPhrases, id: \.id) { item in
                            DraggableCard(text: item.text!, example: item.example ?? "") {
                                viewModel.moveToBack()
                            }
                        }
                    }
                }.navigationTitle("Phrases").toolbar {
                    /*ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            
                        } label : {
                            Image(systemName: "heart.text.square")
                        }
                    }*/
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button(action: {
                                
                                /// // Crea un nuevo registro de la entidad PhraseEntity
                                    /// INSERT nuevo registro
                                let phrase = PhraseEntity(context: context)
                                phrase.id = 6
                                phrase.text = "Save"
                                
                                do {
                                    /// Persiste cambios en disco
                                        /// COMMIT / guardar en base de datos
                                    try context.save()
                                    print("✅ Guardado en Core Data")
                                } catch {
                                    print("❌ Error: \(error)")
                                }
                            }){
                                Image(systemName: "bookmark")
                            }
                            
                            NavigationLink {
                                InfoListView(phrases: $viewModel.randomPhrases)
                            } label : {
                                Image(systemName: "list.bullet")
                            }
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.loadPhrases()
        }
    }
}
