//
//  WordListView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

struct WordListView: View {
    @EnvironmentObject var wordStore: WordStore
    @Binding var searchText: String

    var filteredWords: [Word] {
        if searchText.isEmpty {
            return wordStore.combinedWords
        } else {
            return wordStore.combinedWords.filter { $0.word.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredWords) { word in
                    ZStack {
                        // 🔹 見えない NavigationLink を配置し、デフォルト矢印 (`>`) を削除
                        NavigationLink(destination: AddSentenceView(word: word.word)) {
                            EmptyView()
                        }
                        .opacity(0) // 🔹 非表示にする

                        VStack(alignment: .leading, spacing: 8) {
                            Text(word.word)
                                .font(.system(size: 22, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let sentence = word.sentence {
                                Text(sentence)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("No sentence yet.")
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 15, leading:15, bottom: 15, trailing: 15))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.savedWords = [
        Word(word: "Example", sentence: "This is an example sentence."),
        Word(word: "Swift", sentence: "Swift is a powerful programming language."),
        Word(word: "Design", sentence: "Good UI/UX design improves user experience."),
        Word(word: "Code", sentence: nil) // 🔹 No sentence yet
    ]

    return WordListView(searchText: .constant(""))
        .environmentObject(mockStore)
}
