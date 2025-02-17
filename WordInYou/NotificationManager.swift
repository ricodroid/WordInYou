//
//  NotificationManager.swift
//  WordInYou
//
//  Created by riko on 2025/02/16.
//
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
        content.body = word.sentence?.isEmpty == false ? "Example: \(word.sentence!)" : "Can you make a sentence using this word?"
        
        content.sound = .default
        content.userInfo = ["word": word.word] // 通知タップ時に渡すデータ

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 600, repeats: false) // 🔹 10分後に1回だけ通知

        let request = UNNotificationRequest(identifier: "word_notification", content: content, trigger: trigger)

        // 🔹 既存の通知を削除してから新しい通知をスケジュール
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request)
    }

    // 🔹 10分ごとにランダムな単語を通知する（1つだけ）
    func scheduleRepeatedNotifications(wordStore: WordStore) {
        guard let randomWord = wordStore.words.randomElement() else { return }
        scheduleNotification(for: randomWord)
    }
}
