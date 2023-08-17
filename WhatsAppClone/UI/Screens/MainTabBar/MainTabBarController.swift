//
//  MainTabBarController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBar.isTranslucent = false
    }
}
