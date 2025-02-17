//
//  AddWordView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

struct AddWordView: View {
    @State private var newWord: String
    @State private var newSentence = ""
    @EnvironmentObject var wordStore: WordStore
    @Environment(\.presentationMode) var presentationMode

    init(prepopulatedWord: String = "") {
        _newWord = State(initialValue: prepopulatedWord)
    }

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
                presentationMode.wrappedValue.dismiss() // 🔹 追加後に画面を閉じる
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Add Word")
        .padding()
    }
}

#Preview {
    AddWordView(prepopulatedWord: "example")
        .environmentObject(WordStore())
}
