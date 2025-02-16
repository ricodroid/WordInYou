//
//  NotificationManager.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleNotification(for word: Word) {
        let content = UNMutableNotificationContent()
        content.title = word.word
        content.body = word.sentence ?? "Can you make a sentence using this word?"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60 * 60, repeats: false) // 1時間後

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

