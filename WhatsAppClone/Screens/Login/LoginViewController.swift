//
//  LoginViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.primary
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = self.loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
