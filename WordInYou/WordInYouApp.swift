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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showSplash = false
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(wordStore)
                    .onAppear {
                        NotificationManager.shared.requestPermission()
                        NotificationManager.shared.scheduleRepeatedNotifications(wordStore: wordStore)
                    }
            }
        }
    }
}
