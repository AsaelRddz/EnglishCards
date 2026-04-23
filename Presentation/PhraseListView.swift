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
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ZStack {
                    ZStack {
                        
                        /// Por eso se coloca -- id: \.id
                        /// id: 1 → DraggableCard → offset propio
                        /// id: 2 → DraggableCard → offset propio
                        /// id: 3 → DraggableCard → offset propio
                        ForEach(viewModel.phrases, id: \.id) { item in
                            DraggableCard(text: item.text)
                        }
                    }
                }.navigationTitle("Phrases").toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            viewModel.setRandomPhrase()
                        }){
                            Image(systemName: "arrow.trianglehead.clockwise")
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.loadPhrases()
        }
    }
}

struct DraggableCard: View {
    let text: String
    
    /// Estado PERMANENTE → guarda dónde quedó la card después de soltar
    @State private var offset: CGSize = .zero
    
    /// Estado TEMPORAL → solo vive mientras arrastras (se resetea solo)
    @GestureState private var dragOffset: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray)
            .overlay {
                Text(text)
                    .foregroundStyle(.white)
            }
            .padding()
        
            /// Posición final + movimiento actual
                /// offset = posición acumulada
                /// dragOffset = movimiento en tiempo real
            .offset(x: offset.width + dragOffset.width,
                    y: offset.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        
                        ///offset.width += value.translation.width
                        /// offset.height += value.translation.height
                        /// Se guarda la nueva posición
                        offset.width = .zero
                        offset.height = .zero
                    }
            )
    }
}
