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

    // body には View を一つ返す
    var body: some View {
        // Vstack 縦並び HStack 横並び ZStack 重ねる
        VStack {
            Text(word)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.black)
                .padding()
                .underline()
                .cornerRadius(10)
                .shadow(radius: 5)

            if isEditing {
                TextField("Enter a sentence", text: $sentence)
                    .frame(width: 290, height: 400, alignment: .top)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(10)
            } else {
                Text(sentence.isEmpty ? "No sentence available" : sentence)
                    .frame(width: 290, height: 400, alignment: .top)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .cornerRadius(10)
            }
            
            ZStack {
                VStack {
                    Spacer() // 上部にスペースを作る
                    HStack {
                        Spacer() // 左側にスペースを作る
                        Button(action: {
                            withAnimation {
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
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            // 既存のセンテンスを表示
            if let index = wordStore.words.firstIndex(where: { $0.word == word }) {
                sentence = wordStore.words[index].sentence ?? ""
            }
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.words = [Word(word: "example", sentence: "This is an example sentence.")]

    return AddSentenceView(word: "example")
        .environmentObject(mockStore)
}
