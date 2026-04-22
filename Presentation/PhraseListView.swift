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
                Text(viewModel.randomPhrase)
                    .navigationTitle("Phrases").toolbar {
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
