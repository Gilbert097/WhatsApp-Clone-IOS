//
//  ConversationNotificationService.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/10/23.
//

import Foundation
import UserNotifications

public protocol ConversationNotificationService {
    func start()
}

class ConversationNotificationServiceImpl: ConversationNotificationService {
    
    private var TAG: String { String(describing: ConversationNotificationServiceImpl.self) }
    
    private let manager: ConversationEventManager
    private var registration: DatabaseRegisterListener?
    
    public init(manager: ConversationEventManager) {
        self.manager = manager
    }
    
    public func start() {
        guard let userApp = UserSession.shared.read() else { return }
        
        self.manager.registerChangeListener(observer: .init(userId: userApp.id)) { result in
            switch result {
                
            case .success(let model):
                let content = UNMutableNotificationContent()
                content.title = model.userTargetName
                content.body = model.text ?? .init()
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                
                let resquest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(resquest) { error in
                    if let error = error {
                        print("NotificationRequest: \(error.localizedDescription)")
                    }
                }
            case .failure:
                break
            }
        }
    }
}
