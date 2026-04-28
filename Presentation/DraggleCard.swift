//
//  DraggleCard.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 26/04/26.
//

import Foundation
import SwiftUI

struct DraggableCard: View {
    let text: String
    let example : String
    var moveToBack: () -> Void
    
    /// Estado PERMANENTE → guarda dónde quedó la card después de soltar
    @State private var offset: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.gray)
            .overlay {
                VStack {
                    Text(text)
                        .foregroundStyle(.white)
                        .font(.title2)
                    Text(example)
                        .foregroundStyle(.white)
                        .font(.headline)
                }
            }
            .padding()
        
            /// Posición final + movimiento actual
                /// - offset = posición acumulada
                /// - dragOffset = movimiento en tiempo real
                    /// offset.height + dragOffset.height
            .offset(x: offset.width,
                    y: offset.height)
        
            /// la card va rotando mientras se arrastra y cuando es correcto el swipe
            ///     - arrastras 50 → rota ~ 2.5°
            ///     - arrastras 150 → rota ~ 7.5°
            .rotationEffect(.degrees(Double(offset.width / 20)))
            .gesture(
                DragGesture()
                    /// Mientras se arrastra
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 120
                        
                        if abs(value.translation.width) > threshold {
                            /// Dirección del swipe
                            ///     - derecha → +1
                            ///     - izquierda → -1
                            let direction: CGFloat = value.translation.width > 0 ? 1 : -1
                            
                            /// Animación de salida (easeIn ~ empieza lento termina rapido)
                            /// - swipe derecha → 1 * 500 = 500
                            /// - swipe izquierda → -1 * 500 = -500
                            ///     - 500 = valor suficientemente grande para sacarla de la pantalla
                            withAnimation(.easeInOut(duration: 0.3)) {
                                offset.width = direction * 500
                            }
                            
                            Task {
                                try? await Task.sleep(nanoseconds: 300_000_000)
                                moveToBack()
                                
                                /// ajusta la card de nuevo en el centro
                                offset = .zero
                            }
                        } else {
                            /// La card regresa al centro
                            withAnimation(.smooth) {
                                offset = .zero
                            }
                        }
                    }
            )
    }
}

