//
//  AddSentenceView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

struct AddSentenceView: View {
    @EnvironmentObject var wordStore: WordStore
    let word: String
    @State private var sentence = ""

    var body: some View {
        VStack {
            Text("Make a sentence using '\(word)'")
                .font(.headline)
                .padding()

            TextField("Enter a sentence", text: $sentence)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save") {
                if let index = wordStore.words.firstIndex(where: { $0.word == word }) {
                    wordStore.words[index].sentence = sentence
                    wordStore.saveWords()
                }
            }
            .padding()
        }
        .padding()
    }
}

