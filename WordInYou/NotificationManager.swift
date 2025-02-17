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
        content.userInfo = ["word": word.word] // 通知タップ時に渡すデータ

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 600, repeats: true) // 🔹 1分ごとに通知

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    // 🔹 1分ごとにランダムな単語を通知する
    func scheduleRepeatedNotifications(wordStore: WordStore) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 既存の通知をクリア
        if let randomWord = wordStore.words.randomElement() {
            scheduleNotification(for: randomWord)
        }
    }
}
