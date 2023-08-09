//
//  LoginViewControllerImpl.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

public protocol LoginViewController where Self: UIViewController {
    
}

class LoginViewControllerImpl: UIViewController {
    
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
    
    private let loginButton = PrimaryButton(title: "Entrar", weight: .bold)
    private let linkButton = TextButton(title: "Não tem conta? Cadastre-se")
    
    public var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    private func configure() {
        self.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func linkButtonTapped() {
        self.presenter.signUpButtonAction()
    }
}

// MARK: - LoginViewController
extension LoginViewControllerImpl: LoginViewController {
    
}

// MARK: - ViewCode
extension LoginViewControllerImpl: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([logoImageView, emailField, passwordField, loginButton, linkButton])
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
        
        // loginButton
        NSLayoutConstraint.activate([
            self.loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loginButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 32),
            self.loginButton.heightAnchor.constraint(equalToConstant: 55),
            self.loginButton.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        // linkButton
        NSLayoutConstraint.activate([
            self.linkButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.linkButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 8),
            self.linkButton.heightAnchor.constraint(equalToConstant: 30),
            self.linkButton.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
    }
}
