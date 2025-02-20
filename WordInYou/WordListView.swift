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

    var groupedWords: [[Word]] {
        stride(from: 0, to: filteredWords.count, by: 10).map { startIndex in
            let endIndex = min(startIndex + 10, filteredWords.count)
            return Array(filteredWords[startIndex..<endIndex])
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(groupedWords.enumerated()), id: \.offset) { index, group in
                    Section(header: Text("\(index * 10 + 1) ~ \(min((index + 1) * 10, filteredWords.count))")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    ) {
                        ForEach(group) { word in
                            ZStack {
                                NavigationLink(destination: AddSentenceView(word: word.word)) {
                                    EmptyView()
                                }
                                .opacity(0)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(word.word)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
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
                            .listRowInsets(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.savedWords = (1...30).map { i in
        Word(word: "Word \(i)", sentence: i % 2 == 0 ? "Example sentence \(i)" : nil)
    }

    return WordListView(searchText: .constant(""))
        .environmentObject(mockStore)
}
