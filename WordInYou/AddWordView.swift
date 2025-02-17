//
//  AddWordView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

struct AddWordView: View {
    @State private var newWord = ""
    @State private var newSentence = ""
    @EnvironmentObject var wordStore: WordStore

    var body: some View {
        VStack {
            TextField("Enter a word", text: $newWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter a sentence (optional)", text: $newSentence)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let word = Word(word: newWord, sentence: newSentence.isEmpty ? nil : newSentence)
                wordStore.addWord(word: word)
                newWord = ""
                newSentence = ""
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Add Word")
        .padding()
    }
}

#Preview {
    AddWordView()
        .environmentObject(WordStore()) // 🔹 プレビュー用に environmentObject を追加
}
