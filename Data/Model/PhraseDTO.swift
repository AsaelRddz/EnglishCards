//
//  PhraseResponse.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

import Foundation

struct PhraseDTO: Decodable {
    let id: Int
    let text: String
    let example: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case text = "Text"
        case example = "Example"
        case description = "Description"
    }
}
