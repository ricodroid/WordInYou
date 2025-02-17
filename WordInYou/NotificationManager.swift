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
        
        // 🔹 センテンスがない場合は入力を促す
        if let sentence = word.sentence {
            content.body = "Example: \(sentence)"
        } else {
            content.body = "Can you make a sentence using this word?"
        }

        content.sound = .default
        content.userInfo = ["word": word.word] // 🔹 通知タップ時に渡すデータ

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // 10秒後（テスト用）

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
