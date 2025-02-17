//
//  WordStore.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

class WordStore: ObservableObject {
    @Published var words: [Word] = []

    // 🔹 アプリが持っているデフォルト単語（センテンスなし）
    private let defaultWords: [Word] = [
        Word(word: "apple"),
        Word(word: "book"),
        Word(word: "friend"),
        Word(word: "happy"),
        Word(word: "travel")
    ]

    init() {
        loadWords()
        if words.isEmpty { // 🔹 初回起動時にデフォルト単語をセット
            words = defaultWords
            saveWords()
        }
    }

    func addWord(_ word: Word) {
        words.append(word)
        saveWords()
    }

    func saveWords() {
        if let encoded = try? JSONEncoder().encode(words) {
            UserDefaults.standard.set(encoded, forKey: "SavedWords")
        }
    }

    func loadWords() {
        if let savedData = UserDefaults.standard.data(forKey: "SavedWords"),
           let decoded = try? JSONDecoder().decode([Word].self, from: savedData) {
            words = decoded
        }
    }

    func scheduleDailyNotification() {
        guard let randomWord = words.randomElement() else { return }
        NotificationManager.shared.scheduleNotification(for: randomWord)
    }
}
