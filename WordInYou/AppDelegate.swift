//
//  AppDelegate.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // 🔹 通知がタップされた時の処理
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if let word = response.notification.request.content.userInfo["word"] as? String {
            NotificationCenter.default.post(name: .showSentenceInput, object: word)
        }
        completionHandler()
    }
}

// 🔹 通知を受け取るカスタム NotificationCenter
extension Notification.Name {
    static let showSentenceInput = Notification.Name("showSentenceInput")
}

