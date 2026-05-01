import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    private let center = UNUserNotificationCenter.current()
    private let dailyReminderID = "com.ggsheng.PetHabit.dailyReminder"

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in DispatchQueue.main.async { completion(granted) } }
    }

    func schedulePetReminder(at hour: Int = 9) {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
        let content = UNMutableNotificationContent()
        content.title = "🐾 PetHabit"
        content.body = "Your pet needs care today! Check their health stats and activity tracking."
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: hour, minute: 0), repeats: true)
        let request = UNNotificationRequest(identifier: dailyReminderID, content: content, trigger: trigger)
        center.add(request) { error in if let e = error { print("Notification error: \(e)") } }
    }

    func cancelAll() { center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID]) }
    var isEnabled: Bool { get { UserDefaults.standard.bool(forKey: "PetHabit.notificationsEnabled") } set { UserDefaults.standard.set(newValue, forKey: "PetHabit.notificationsEnabled") } }

    func toggle(enabled: Bool, completion: @escaping (Bool) -> Void) {
        if enabled { requestAuthorization { [weak self] granted in if granted { self?.isEnabled = true; self?.schedulePetReminder(); completion(true) } else { completion(false) } } }
        else { isEnabled = false; cancelAll(); completion(true) }
    }
    func restoreScheduledNotifications() { if isEnabled { schedulePetReminder() } }
}
