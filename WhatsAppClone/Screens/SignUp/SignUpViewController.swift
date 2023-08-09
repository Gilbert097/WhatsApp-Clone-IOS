//
//  SignUpViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 09/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
        return view
    }()
    
    private let passwordField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "Digite sua senha"
        view.isSecureTextEntry = true
        return view
    }()
    
    private let signUpButton = PrimaryButton(title: "Cadastrar", weight: .bold)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - ViewCode
extension SignUpViewController: ViewCode {
    
    func setupViewHierarchy() {
        
        formStack.addArrangedSubviews([nameField,
                                       emailField,
                                       passwordField])
        mainView.addSubviews([logoImageView, formStack, signUpButton])
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
            self.logoImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 110),
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
        
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
    }
}
