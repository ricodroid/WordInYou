//
//  WordStore.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

class WordStore: ObservableObject {
    @Published var savedWords: [Word] = []
    private let defaultWords: [Word] = [
        Word(word: "ability"),
        Word(word: "able"),
        Word(word: "about"),
        Word(word: "above"),
        Word(word: "accept"),
        Word(word: "according"),
        Word(word: "account"),
        Word(word: "across"),
        Word(word: "act"),
        // ここに 3000 語のリスト
    ]

    init() {
        loadWords()
    }

    
    var combinedWords: [Word] {
        let savedWordsSet = Set(savedWords.map { $0.word })
        return savedWords + defaultWords.filter { !savedWordsSet.contains($0.word) }
    }


    func addWord(word: Word) {
        savedWords.append(word)
        saveWords()
    }

    func updateSentence(for word: String, sentence: String) {
        if let index = savedWords.firstIndex(where: { $0.word == word }) {
            savedWords[index].sentence = sentence
        } else if let defaultIndex = defaultWords.firstIndex(where: { $0.word == word }) {
            var updatedWord = defaultWords[defaultIndex]
            updatedWord.sentence = sentence
            savedWords.append(updatedWord)
        }
        saveWords()
    }

    func saveWords() {
        if let encoded = try? JSONEncoder().encode(savedWords) {
            UserDefaults.standard.set(encoded, forKey: "savedWords")
        }
    }

    func loadWords() {
        if let savedData = UserDefaults.standard.data(forKey: "savedWords"),
           let decodedWords = try? JSONDecoder().decode([Word].self, from: savedData) {
            savedWords = decodedWords
        }
    }
}
