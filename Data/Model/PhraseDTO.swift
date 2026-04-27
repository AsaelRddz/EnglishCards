//
//  PhraseResponse.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 18/04/26.
//

import Foundation

struct PhraseDTO: Decodable {
    let id: Int
    let description: String
    let text: String
    let example: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case description = "Description"
        case text = "Text"
        case example = "Example"
    }
}
