//
//  WordListView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

struct WordListView: View {
    @EnvironmentObject var wordStore: WordStore

    var body: some View {
        VStack {
            List(wordStore.words) { word in
                VStack(alignment: .leading) {
                    Text(word.word)
                        .font(.headline)
                    if let sentence = word.sentence {
                        Text(sentence)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        Text("No sentence yet.")
                            .foregroundColor(.red)
                    }
                }
            }
            
            NavigationLink(destination: AddWordView()) {
                Text("Add New Word")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Word List")
    }
}

#Preview {
    WordListView()
        .environmentObject(WordStore()) // 🔹 プレビュー用に environmentObject を追加
}
