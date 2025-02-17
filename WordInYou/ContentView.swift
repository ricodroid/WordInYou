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

    var body: some View {
        NavigationView {
            WordListView()
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
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(WordStore()) // 🔹 プレビュー用に environmentObject を追加
}
