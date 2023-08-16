//
//  LoginViewControllerImpl.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

public protocol LoginViewController: LoadingView, AlertView where Self: UIViewController {
    
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
        view.autocapitalizationType = .none
        view.text = "gilberto.silva@gmail.com"
        return view
    }()
    
    private let passwordField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let loginButton = PrimaryButton(title: "Entrar", weight: .bold)
    private let linkButton = TextButton(title: "Não tem conta? Cadastre-se")
    
    public var presenter: LoginPresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
        self.presenter.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.stop()
    }
    
    private func configure() {
        self.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func linkButtonTapped() {
        self.presenter.linkButtonAction()
    }
    
    @objc private func loginButtonTapped() {
        self.presenter.loginButtonAction(request: .init(email: self.emailField.text!, password: self.passwordField.text!))
    }
}

// MARK: - LoginViewController
extension LoginViewControllerImpl: LoginViewController {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = AlertFactory.build(viewModel: viewModel)
        present(alert, animated: true)
    }
}

// MARK: - ViewCode
extension LoginViewControllerImpl: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([logoImageView, emailField, passwordField, loginButton, linkButton, loadingView])
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
        
        // loadingView
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
        self.loadingView.isHidden = true
    }
}
