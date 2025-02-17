//
//  ContentView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var selectedWord: String? = nil
    @State private var isShowingAddSentence = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if isSearching {
                    // 検索バー
                    TextField("Search...", text: $searchText)
                        .padding(15)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal, 16)
                }

                WordListView(searchText: $searchText)
                    .onReceive(NotificationCenter.default.publisher(for: .showSentenceInput)) { notification in
                        if let word = notification.object as? String {
                            selectedWord = word
                            isShowingAddSentence = true
                        }
                    }
                    .sheet(isPresented: $isShowingAddSentence) {
                        if let word = selectedWord {
                            AddSentenceView(word: word)
                        }
                    }
                    .scrollContentBackground(.hidden)
            }
            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
            .navigationTitle("Word List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isSearching.toggle()
                            if !isSearching { searchText = "" }
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 70)
                            .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                            .cornerRadius(10)
                            .shadow(radius: 4)
                    }

                }
            }
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.words = [
        Word(word: "Apple", sentence: "This is an apple."),
        Word(word: "Banana", sentence: "Bananas are yellow."),
        Word(word: "Cherry", sentence: "I like cherries."),
    ]

    return ContentView()
        .environmentObject(mockStore)
}
