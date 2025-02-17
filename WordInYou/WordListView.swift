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
        VStack {
            List {
                ForEach(filteredWords) { word in  // 🔹 `filteredWords` を表示
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
                    .padding(24)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 8)
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)

            NavigationLink(destination: AddWordView()) {
                Text("Add New Word")
                    .frame(maxWidth: .infinity)
                    .frame(height: 35)
                    .padding()
                    .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color(red: 0.9, green: 0.95, blue: 1.0))
        .navigationTitle("Word List")
    }
}
