//
//  LoginViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let emailField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite seu e-mail"
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let passwordField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - ViewCode
extension LoginViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([logoImageView, emailField, passwordField])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        // emailField
        NSLayoutConstraint.activate([
            self.emailField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.emailField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            self.emailField.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 24),
            self.emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // passwordField
        NSLayoutConstraint.activate([
            self.passwordField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.passwordField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 16),
            self.passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
    }
}
