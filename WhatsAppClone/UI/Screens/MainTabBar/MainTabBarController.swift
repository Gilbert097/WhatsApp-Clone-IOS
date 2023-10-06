//
//  MainTabBarController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import UIKit
import UserNotifications

public protocol MainTabBarView where Self: UITabBarController {
    
}

class MainTabBarController: UITabBarController, MainTabBarView {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        let content = UNMutableNotificationContent()
        content.title = "Hey I'm a notification!"
        content.body = "Look at me!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let resquest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(resquest) { error in
            if let error = error {
                print("NotificationRequest: \(error.localizedDescription)")
            }
        }
    }
}


