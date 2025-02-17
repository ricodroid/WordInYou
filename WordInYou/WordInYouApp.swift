//
//  WordInYouApp.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
import SwiftUI

@main
struct WordInYouApp: App {
    @StateObject var wordStore = WordStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // 🔹 AppDelegate をセット

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(wordStore)
                .onAppear {
                    NotificationManager.shared.requestPermission()
                    NotificationManager.shared.scheduleRepeatedNotifications(wordStore: wordStore)
                }
        }
    }
}
