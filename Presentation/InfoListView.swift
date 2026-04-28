//
//  GeneralListView.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 24/04/26.
//

import Foundation
import SwiftUI

struct InfoListView: View {
    
    @Binding var phrases : [Phrase]
    @State var showFavs = false
    
    var body : some View {
        var filteredPhrases: [Phrase] {
            showFavs ? phrases.filter { $0.favorite } : phrases
        }
        
        VStack {
            List(filteredPhrases) { item in
                HStack {
                    Text(item.text)
                    Spacer()
                    
                    if item.favorite {
                        Image(systemName: "suit.heart.fill")
                            .foregroundStyle(.red)
                    }
                }.swipeActions(edge: .trailing) {
                    Button (action: {
                        print("save")
                    }){
                        Image(systemName: item.favorite ? "heart.slash" : "suit.heart.fill")
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        showFavs.toggle()
                    }
                }){
                    Image(systemName: showFavs ? "suit.heart.fill" : "heart").foregroundStyle(.red)
                }
            }
        }
    }
}
