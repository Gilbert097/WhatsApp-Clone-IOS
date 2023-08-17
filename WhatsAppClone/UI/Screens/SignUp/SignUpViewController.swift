//
//  SignUpViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import UIKit

public protocol SignUpViewController: LoadingView, AlertView where Self: UIViewController {
    
}

class SignUpViewControllerImpl: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let formStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "usuario"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let nameField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite seu nome"
        view.keyboardType = .emailAddress
        return view
    }()
    
    private let emailField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite seu e-mail"
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        return view
    }()
    
    private let passwordField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    private let signUpButton = PrimaryButton(title: "Cadastrar", weight: .bold)
    
    public var presenter: SignUpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cadastro"
        setupView()
        configure()
    }
    
    private func configure() {
        self.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        let request = SignUpRequest(name: nameField.text!,
                                    email: emailField.text!,
                                    password: passwordField.text!)
        self.presenter.signUpButtonAction(request: request)
    }
}

// MARK: - SignUpViewController
extension SignUpViewControllerImpl: SignUpViewController {
    
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
extension SignUpViewControllerImpl: ViewCode {
    
    func setupViewHierarchy() {
        
        formStack.addArrangedSubviews([nameField,
                                       emailField,
                                       passwordField])
        mainView.addSubviews([logoImageView, formStack, signUpButton, loadingView])
        scrollView.addSubview(mainView)
        self.view.addSubview(scrollView)
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // mainView
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 30),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 240)
        ])
        
        // formStack
        NSLayoutConstraint.activate([
            self.formStack.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 24),
            self.formStack.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -24),
            self.formStack.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 24)
        ])
        
        // TextFields
        NSLayoutConstraint.activate([
            self.nameField.heightAnchor.constraint(equalToConstant: 40),
            self.emailField.heightAnchor.constraint(equalToConstant: 40),
            self.passwordField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // signUpButton
        NSLayoutConstraint.activate([
            self.signUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.signUpButton.topAnchor.constraint(equalTo: self.formStack.bottomAnchor, constant: 32),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 240),
            self.signUpButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -32)
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

