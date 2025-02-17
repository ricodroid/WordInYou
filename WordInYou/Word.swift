//
//  Word.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import Foundation

struct Word: Identifiable, Codable {
    var id: UUID = UUID()
    var word: String
    var sentence: String? = nil
}
