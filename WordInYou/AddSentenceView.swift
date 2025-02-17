//
//  AddSentenceView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

struct AddSentenceView: View {
    @EnvironmentObject var wordStore: WordStore
    let word: String
    @State private var sentence = ""
    @State private var isEditing = false

    var body: some View {
        VStack {
            // 🔹 単語を大きく表示（見出し）
            Text(word)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
                .padding()
                .underline()
                .shadow(radius: 5)

            // 🔹 編集モードの切り替え
            if isEditing {
                TextField("Enter a sentence", text: $sentence)
                    .padding(20)
                    .frame(width: 290, height: 200, alignment: .top)
                    .background(Color.green.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            } else {
                Text(sentence.isEmpty ? "No sentence available" : sentence)
                    .padding(20)
                    .frame(width: 290, height: 200, alignment: .top)
                    .background(Color.blue.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()

            // 🔹 右下に編集ボタンを配置
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        if isEditing {
                            wordStore.updateSentence(for: word, sentence: sentence) // 🔹 センテンスを保存
                        }
                        isEditing.toggle()
                    }
                }) {
                    Image(systemName: isEditing ? "checkmark" : "pencil")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(isEditing ? Color.green : Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            // 🔹 既存のセンテンスを取得（保存されている場合）
            if let existingSentence = wordStore.combinedWords.first(where: { $0.word == word })?.sentence {
                sentence = existingSentence
            }
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.savedWords = [Word(word: "example", sentence: "This is an example sentence.")]

    return AddSentenceView(word: "example")
        .environmentObject(mockStore)
}
