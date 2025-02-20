//
//  ContentView.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var selectedWord: String? = nil
    @State private var isShowingAddSentence = false
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var isShowingAddWordAlert = false
    @State private var newWord: String?
    
    let miniAnimationFiles = [
        "mini-logo1",
        "mini-logo2",
        "mini-logo3",
        "mini-logo4",
        "mini-logo5"
    ]
    @State private var selectedMiniAnimation: String = UUID().uuidString
    @State private var miniAnimationKey = UUID()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if isSearching {
                        TextField("Search...", text: $searchText, onCommit: {
                            checkWordExists()
                        })
                        .padding(15)
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal, 16)
                        .transition(.move(edge: .top))
                    }
                    
                    Spacer()

                    WordListView(searchText: $searchText)
                        .onReceive(NotificationCenter.default.publisher(for: .showSentenceInput)) { notification in
                            if let word = notification.object as? String {
                                selectedWord = word
                            }
                        }
                        .sheet(isPresented: $isShowingAddSentence) {
                            if let word = selectedWord {
                                AddSentenceView(word: word)
                                    .environmentObject(wordStore)
                            }
                        }
                        .scrollContentBackground(.hidden)
                    
                    HStack(spacing: 16) { // 🔹 横並びにする
                        NavigationLink(destination: AddWordView()) {
                            Text("Add New Word")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                        }

                        Button(action: {
                            withAnimation {
                                isSearching.toggle()
                                if !isSearching { searchText = "" }
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color(red: 51/255, green: 51/255, blue: 51/255))
                                .clipShape(Circle())
                                .shadow(radius: 4)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity) // 🔹 HStack を画面幅いっぱいに
                    .padding(.horizontal, 16) // 🔹 左右の余白を追加

                }
                .background(Color(red: 0.9, green: 0.95, blue: 1.0))
                .toolbar {

                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Word 2000")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }

                    ToolbarItem(placement: .navigationBarTrailing) {
                        LottieView(filename: selectedMiniAnimation, loopMode: .loop)
                            .id(miniAnimationKey)
                            .frame(width: 30, height: 30)
                            .scaleEffect(0.15)
                            .padding(.trailing, 40)
                            .onAppear {
                                DispatchQueue.main.async {
                                    selectedMiniAnimation = miniAnimationFiles.randomElement() ?? "mini-anime1"
                                    miniAnimationKey = UUID()
                                    print("タイトル: \(selectedMiniAnimation)") 
                                }
                            }
                    }
                }



                
            }
            .alert("単語が見つかりません", isPresented: $isShowingAddWordAlert) {
                Button("キャンセル", role: .cancel) {}
                Button("Yes") {
                    newWord = searchText
                }
            } message: {
                Text("新しい単語を追加しますか？")
            }
            .navigationDestination(item: $newWord) { word in
                AddWordView(prepopulatedWord: word)
            }
            .navigationDestination(item: $selectedWord) { word in
                AddSentenceView(word: word)
            }
        }
        .onAppear {
            selectedWord = nil
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                checkForNotificationTap()
            }
        }
    }

    private func checkForNotificationTap() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            print("取得した通知数: \(notifications.count)")
            for notification in notifications {
                if let word = notification.request.content.userInfo["word"] as? String {
                    DispatchQueue.main.async {
                        print("通知から取得した単語: \(word)")
                        selectedWord = word // ここが問題！
                    }
                }
            }
        }
    }


    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if let word = response.notification.request.content.userInfo["word"] as? String {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .showSentenceInput, object: word)
            }
        }
        completionHandler()
    }

    private func checkWordExists() {
        let wordExists = wordStore.combinedWords.contains { $0.word.lowercased() == searchText.lowercased() }
        if !wordExists {
            isShowingAddWordAlert = true
        }
    }
}

#Preview {
    let mockStore = WordStore()
    mockStore.savedWords = [
        Word(word: "Apple", sentence: "This is an apple."),
        Word(word: "Banana", sentence: "Bananas are yellow."),
        Word(word: "Cherry", sentence: "I like cherries."),
    ]

    return ContentView()
        .environmentObject(mockStore)
}
