//
//  AddSentenceView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI
import Lottie

struct AddSentenceView: View {
    @EnvironmentObject var wordStore: WordStore
    let word: String
    @State private var sentence = ""
    @State private var isEditing = false
    let animationFiles = [
        "lottie-anime1",
        "lottie-anime2",
        "lottie-anime3",
        "lottie-anime4",
        "lottie-anime5",
        "lottie-anime6",
        "lottie-anime7",
        "lottie-anime8",
        "lottie-anime9",
        "lottie-anime10"
        
    ]
    @State private var selectedAnimation: String = ""

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

            LottieView(filename: selectedAnimation, loopMode: .loop)
                .frame(height: 20)
                .scaleEffect(0.4)
                .onAppear {
                    selectedAnimation = animationFiles.randomElement() ?? "lottie-anime1"
                    print("Selected animation: \(selectedAnimation)")
                }
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        if isEditing {
                            wordStore.updateSentence(for: word, sentence: sentence)
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
