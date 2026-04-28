//
//  PhraseListView.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 21/04/26.
//

import Foundation
import SwiftUI
import Combine

struct PhraseListView : View {
    
    @StateObject private var viewModel: PhraseViewModel
    
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
                        ForEach(viewModel.randomPhrases, id: \.id) { item in
                            DraggableCard(text: item.text, example: item.example) {
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
                        NavigationLink {
                            InfoListView(phrases: $viewModel.randomPhrases)
                        } label : {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.loadPhrases()
        }
    }
}
