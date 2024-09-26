//
//  LoginViewControllerImpl.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit
import BackgroundTasks

public protocol LoginView: LoadingView, AlertView where Self: UIViewController {
    
}

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.submitBackgroundTask()
        })
    }
    
    private func submitBackgroundTask() {

        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: AppDelegate.taskId)
        
        // check if there is a pending task request or not
        BGTaskScheduler.shared.getPendingTaskRequests { request in
            print("\(request.count) BGTask pending.")
            guard request.isEmpty else { return }
            // Create a new background task request
            let request = BGProcessingTaskRequest(identifier: AppDelegate.taskId)
            request.requiresNetworkConnectivity = false
            request.requiresExternalPower = false
            //request.earliestBeginDate = Date().addingTimeInterval(86400 * 3)
            
            do {
                // Schedule the background task
                try BGTaskScheduler.shared.submit(request)
                
                // Manual test: e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"whatsapp.clone.background.task.identifier"]
                // Colocar break point na linha 82 e executar,  ao parar na linha, executa script acima no log.
                print("Task scheduled")
            } catch {
                print("Unable to schedule background task: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.stop()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
extension LoginViewController: LoginView {
    
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
extension LoginViewController: ViewCode {
    
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
