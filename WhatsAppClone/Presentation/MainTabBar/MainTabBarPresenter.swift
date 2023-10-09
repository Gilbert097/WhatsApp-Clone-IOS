//
//  MainTabBarPresenter.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/10/23.
//

import Foundation

public protocol MainTabBarPresenter: AnyObject {
    func start()
}

class MainTabBarPresenterImpl: MainTabBarPresenter {
    
    private weak var view: MainTabBarView?
    private let notificationService: ConversationNotificationService
    
    public init(view: MainTabBarView, notificationService: ConversationNotificationService) {
        self.view = view
        self.notificationService = notificationService
    }
    
    public func start() {
        self.notificationService.start()
    }
}
