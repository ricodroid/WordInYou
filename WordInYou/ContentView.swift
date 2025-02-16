//
//  ContentView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WordListView() // 🔹 ここで単語リストを表示
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WordStore()) // 🔹 プレビュー用に environmentObject を追加
}
