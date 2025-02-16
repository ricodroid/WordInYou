//
//  WordStore.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

class WordStore: ObservableObject {
    @Published var words: [Word] = []

    init() {
        loadWords()
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

