//
//  AppDelegate.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit
import FirebaseCore
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public static let taskId = "whatsapp.clone.background.task.identifier"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                print("requestAuthorization: \(granted)")
                center.removeAllPendingNotificationRequests()
            }
        }
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: AppDelegate.taskId, using: nil) { task in
            print("forTaskWithIdentifier called!")
            guard let task = task as? BGProcessingTask else { return }
            // your task impelementation goes here
            self.handleBackgroundTask(task: task)
        }
        
        return true
    }
    
    func handleBackgroundTask(task: BGProcessingTask) {
        print("handleBackgroundTask called!")
        // Perform background task work here (e.g., trigger local notifications)
        scheduleNotification()
        
        // Mark the task as completed
        task.setTaskCompleted(success: true)
    }
    
    func scheduleNotification() {
        print("scheduleNotification called!")
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.body = "This is a local notification example."
        content.sound = .default
        
        // Create a trigger for the notification (every 2 minutes)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 120, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // Create a request with a unique identifier
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
