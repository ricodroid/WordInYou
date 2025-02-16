//
//  WordInYouApp.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI

@main
struct WordInYouApp: App {
@StateObject var wordStore = WordStore() // アプリ全体で使うために @StateObject を設定

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordStore) // 🔹 ここで `environmentObject` を渡す
                .onAppear {
                    NotificationManager.shared.requestPermission()
                    wordStore.scheduleDailyNotification()
                }
        }
    }
}
