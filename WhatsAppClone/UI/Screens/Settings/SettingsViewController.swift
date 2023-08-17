//
//  SettingsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 16/08/23.
//

import UIKit

public protocol SettingsViewController where Self: UIViewController {
    
}

class SettingsViewControllerImpl: UIViewController, SettingsViewController {
    
    private lazy var logoutButtonItem: UIBarButtonItem = {
      let item = UIBarButtonItem(
            title: "Deslogar",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
        item.tintColor = .systemRed
        return item
    }()
    
    public var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Ajustes"
        self.parent?.navigationItem.rightBarButtonItem = self.logoutButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func logoutButtonTapped() {
        self.presenter.logoutButtonAction()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
