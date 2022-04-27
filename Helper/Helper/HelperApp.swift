//
//  HelperApp.swift
//  Helper
//
//  Created by SonDang, MyMai, AnHuynh on 1.4.2022.
//

import SwiftUI
import UserNotifications

@main
struct HelperApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
        let _ = registerForPushNotifications()
    }
    
}

func getNotificationSettings() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
}


func registerForPushNotifications() {
    //1
    UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            getNotificationSettings()
            requestNotification()
        }
}

func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("Device Token: \(token)")
}

func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
) {
    print("Failed to register: \(error)")
}


func requestNotification() {
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: "Someone needs you right now!", arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "Open the app to see new tasks.", arguments: nil)
    content.sound = UNNotificationSound.default
    content.badge = 1
    
    let identifier = UIDevice.current.identifierForVendor?.uuidString ?? "D03FFB27-BD42-42E6-B711-9CEC16F2B6BF" + "SonDang-MyMai-AnHuynh.Helper"
    print("device identifier: \(identifier)")
    //Receive notification after 5 sec
    //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    //Receive with date
    var datComp = DateComponents()
    datComp.hour = 10
    datComp.minute = 30
    let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    let center = UNUserNotificationCenter.current()
    print(identifier)
    center.add(request) { (error) in
        if let error = error {
            print("Error \(error.localizedDescription)")
        }else{
            print("send!!")
        }
    }
}

