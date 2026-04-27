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
    
    var body : some View {
        List(phrases) { item in
            Text(item.text)
        }
    }
}
