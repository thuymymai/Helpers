////
////  Notification.swift
////  Helper
////
////  Created by Dang Son on 2.5.2022.
////
//
//import SwiftUI
//
//func getNotificationSettings() {
//    UNUserNotificationCenter.current().getNotificationSettings { settings in
//        guard settings.authorizationStatus == .authorized else { return }
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//}
//
//func registerForPushNotifications() {
//    UNUserNotificationCenter.current()
//        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
//            guard granted else { return }
//            getNotificationSettings()
//            requestNotification()
//        }
//}
//
//func application(
//    _ application: UIApplication,
//    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//) {
//    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//    let _ = tokenParts.joined()}
//
//func application(
//    _ application: UIApplication,
//    didFailToRegisterForRemoteNotificationsWithError error: Error
//) {
//    print("Failed to register: \(error)")
//}
//
//
//func requestNotification() {
//    let content = UNMutableNotificationContent()
//    content.title = NSString.localizedUserNotificationString(forKey: "New tasks updated!", arguments: nil)
//    content.body = NSString.localizedUserNotificationString(forKey: "Open the app to see new tasks.", arguments: nil)
//    content.sound = UNNotificationSound.default
//    content.badge = 1
//
//    let identifier = UIDevice.current.identifierForVendor?.uuidString ?? "D03FFB27-BD42-42E6-B711-9CEC16F2B6BF" + "SonDang-MyMai-AnHuynh.Helper"
//
//    //Receive with date
//    var datComp = DateComponents()
//    let date = Date()
//    datComp.hour = Calendar.current.dateComponents([.hour], from: date).hour
//    datComp.minute = (Calendar.current.dateComponents([.minute], from: date).minute)! + 1
//
//    let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
//    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//    let center = UNUserNotificationCenter.current()
//
//    center.add(request) { (error) in
//        if let error = error {
//            print("Error \(error.localizedDescription)")
//        } else {
//            print("Notification sent!")
//        }
//    }
//}
