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
    
    public var presenter: MainTabBarPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.presenter.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.isTranslucent = false
    }
}


